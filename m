Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbTBPOAb>; Sun, 16 Feb 2003 09:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbTBPOAb>; Sun, 16 Feb 2003 09:00:31 -0500
Received: from a089108.adsl.hansenet.de ([213.191.89.108]:55946 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S266765AbTBPOAa>;
	Sun, 16 Feb 2003 09:00:30 -0500
Message-ID: <3E4F9B08.8040701@portrix.net>
Date: Sun, 16 Feb 2003 15:07:04 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Reply-To: j.dittmer@portrix.net
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Dominik Brodowski <linux@brodo.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Link failure with current bk w/o CONFIG_X86_POWERNOW_K6
References: <3E4F7A0E.30305@portrix.net> <20030216123742.GA28689@brodo.de>
In-Reply-To: <20030216123742.GA28689@brodo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> On Sun, Feb 16, 2003 at 12:46:22PM +0100, Jan Dittmer wrote:
> 
>>Happens with CONFIG_X86_POWERNOW_K6 disabled, ie. you cannot enable 
>>CONFIG_X86_POWERNOW_K7 w/o enabling CONFIG_X86_POWERNOW_K7.
> 
> 
> Using your .config, I can't reproduce this link error - I tested it with
> CONFIG_X86_POWERNOW_K7 && CONFIG_X86_POWERNOW_K6
> CONFIG_X86_POWERNOW_K7 && !CONFIG_X86_POWERNOW_K6
> !CONFIG_X86_POWERNOW_K7 && CONFIG_X86_POWERNOW_K6
> !CONFIG_X86_POWERNOW_K7 && !CONFIG_X86_POWERNOW_K6
> 
> Might it be that you have some other patch added to the kernel, which causes
> a reject for linux/drivers/Makefile?

CONFIG_X86_POWERNOW_K7 && !CONFIG_X86_POWERNOW_K6 was the one causing 
the error. But I can't reproduce it anymore either. Perhaps I missed a 
'make clean' in between?!

Thanks, Jan




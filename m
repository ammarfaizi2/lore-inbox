Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbTGEQx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266410AbTGEQx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:53:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:449 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266409AbTGEQx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:53:26 -0400
Message-ID: <3F0705E1.2090200@pobox.com>
Date: Sat, 05 Jul 2003 13:07:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Ryan Mack <lists@mackman.net>
CC: Markus Plail <linux-kernel@gitteundmarkus.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 ServerWorks DMA Bugs
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net> <87fzllh21i.fsf@gitteundmarkus.de> <Pine.LNX.4.53.0307050956060.2029@mackman.net>
In-Reply-To: <Pine.LNX.4.53.0307050956060.2029@mackman.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Mack wrote:
> That at least explains the lack of DMA, but why does non-DMA IO result in 
> such significant clock skew?

Sounds like the kernel is disabling interrupts for a long time, when 
doing PIO data transfer (non-DMA IO).

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUJEXMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUJEXMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUJEXIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:08:50 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:17421 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S266560AbUJEXG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:06:28 -0400
Message-ID: <416328F4.5010201@optonline.net>
Date: Tue, 05 Oct 2004 19:06:28 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.5-1.358 SMP
References: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Hello,
> 
> I almost have everything converted over from 2.4.26 to
> 2.6.whatever.
> 
> I need to make some modules that have lots of assembly code.
> This assembly uses the UNIX calling convention and can't be
> re-written (it would take many months). The new kernel
> is compiled with "-mregparam=2". I can't find where that's
> defined. I need to remove it because I cannot pass parameters
> to the assembly stuff in registers.
> 
> Where is it defined??? I grepped through all the scripts and
> the hidden files, but I can't discover where it's defined.

In the 2.6.8 that's shipping in Fedora, it's a config option: CONFIG_REGPARM

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTEPPzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTEPPzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 11:55:40 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:20969 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S264477AbTEPPzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 11:55:38 -0400
Message-ID: <3EC50CD9.6020508@cox.net>
Date: Fri, 16 May 2003 12:07:53 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Support for SiS 961/961B/962/963/630S/630ET/633/733 IDE
References: <20030516143021.A17346@ucw.cz>
In-Reply-To: <20030516143021.A17346@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> Hi!
> 
> The goal of this patch is to add support for the new generation of
> MuTIOL southbridges by SiS, namely the 961/961B, 962 and 963. These
> integrate the IDE controller, unlike all other SiS chipsets where the
> controller is bound to the northbridge.
> 
> I had to do quite some research on what SiS IDE controllers exist that
> don't use the 96* southbridges, and thus found out that the 633 and 733
> controllers were missing. So those were added too.
> 
> This patch hovewer integrates a patch from Lionel which adds 630S/ET
> UDMA100 support.
> 
> And while doing the changes I did also some cleanups, mainly removing a
> bunch of debug code that doesn't seem very useful when lspci does the
> same job. And removing the config_drive_xfer_rate in favor of functions
> from ide-timing.h.
> 
> Tested on SiS963, works great.
> 
> Patches for current 2.4 and 2.5 attached.

I never thought about it, but my SiS963 is not recognized in lspci. The 
below is a link which has a diagram of the SiS648/SiS963 combo that is 
on my motherboard. Would it enhance performance any or would this 
correction just be cosmetic?

Thanks,
David

Link: http://www.sis.com/products/chipsets/oa/pentium4/648.htm


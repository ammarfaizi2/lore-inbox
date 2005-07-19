Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVGSVDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVGSVDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVGSVDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:03:48 -0400
Received: from hermes.domdv.de ([193.102.202.1]:56586 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261992AbVGSVDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:03:47 -0400
Message-ID: <42DD6AA7.40409@domdv.de>
Date: Tue, 19 Jul 2005 23:03:35 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
CC: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
References: <42DD67D9.60201@stud.feec.vutbr.cz>
In-Reply-To: <42DD67D9.60201@stud.feec.vutbr.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt wrote:
> Hello,
> 
> Does resuming from swsuspend work for anyone with amd64-agp loaded?
> 
> On my system when I suspend with amd64-agp loaded, I get a spontaneous
> reboot on resume. It reboots immediately after reading the saved image
> from disk.
> This is 100% reproducible.
> 
> Athlon 64 FX-53, Asus A8V Deluxe, Linux 2.6.13-rc3-mm1.

AMD Athlon(tm) 64 Processor 3000+, Acer Aspire

Linux gringo 2.6.13-rc3-gringo #36 Sun Jul 17 15:57:17 CEST 2005 x86_64
unknown unknown GNU/Linux

CONFIG_AGP=y
CONFIG_AGP_AMD64=y

swsusp works for me. Could it be mm, agp as a module or some speciality
of your hardware?
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbUKPOrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUKPOrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUKPOrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:47:20 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:44293 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261974AbUKPOrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:47:17 -0500
Message-ID: <419A12DF.6010903@techsource.com>
Date: Tue, 16 Nov 2004 09:46:55 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel Corp. 82801BA/BAM not supported by ALSA?
References: <419914F9.7050509@techsource.com> <52is86lqur.fsf@topspin.com>	<41992C5C.9060201@techsource.com> <521xeulonk.fsf@topspin.com>
In-Reply-To: <521xeulonk.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> This is the audio device:
> 
>     > 0000:00:1f.5 Class 0401: 8086:2445 (rev 04)
> 
> and it looks like sound/pci/intel8x0.c should support it:
> 
> static struct pci_device_id snd_intel8x0_ids[] = {
> 	/* ... */
> 	{ 0x8086, 0x2445, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 82801BA */
> 
> What happens when you load snd_intel8x0?
> 
>  - Roland
> 
> 

I had compiled it directly in the kernel.  Does it not work unless it's 
a module?


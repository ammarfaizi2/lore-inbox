Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUKIMLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUKIMLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbUKIMKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:10:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11213 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261507AbUKIMKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:10:20 -0500
Subject: Re: Kernel or failing harddisc?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: alistair@devzero.co.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411090054.48164.alistair@devzero.co.uk>
References: <200411090054.48164.alistair@devzero.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099998443.15469.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 11:07:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-09 at 00:54, Alistair John Strachan wrote:
> Hi,
> 
> Periodically, especially while playing large files with Xine (~1.4GB OGMs), 
> playback will pause for up to 10 seconds. I see the following in dmesg;
> 
> hda: dma_timer_expiry: dma status == 0x64
> hda: DMA interrupt recovery
> hda: lost interrupt
> 
> The drive then recovers and playback resumes, no problem.
> 
> Is this likely to be the first signs of a faulty HD, or is it some known 
> problem? In the event that it's the HD, has anybody been able to successfully 
> RMA a Maxtor which has this, albeit minor, problem?

It could be anything. An interrupt went walkies which could easily be
the driver, thermals, cabling, phase of the moon, drive,... If those are
the only logged lines then the drive hasn't reported any problems back.

Failed maxtors normally make it very clear they died - both in smart
data (usually) and by spewing drive level errors.

Alan




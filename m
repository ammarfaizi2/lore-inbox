Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUAANFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 08:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUAANFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 08:05:21 -0500
Received: from pD9E56CE4.dip.t-dialin.net ([217.229.108.228]:23941 "EHLO
	fred.muc.de") by vger.kernel.org with ESMTP id S261492AbUAANFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 08:05:14 -0500
To: Leon Toh <tltoh@attglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel  
 Configuration Tool
From: Andi Kleen <ak@muc.de>
Date: Tue, 30 Dec 2003 06:19:36 +0100
In-Reply-To: <18jZB-4VF-19@gated-at.bofh.it> (Leon Toh's message of "Tue, 30
 Dec 2003 05:50:15 +0100")
Message-ID: <m37k0eyj9z.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <179fQ-1iK-11@gated-at.bofh.it> <17TiY-4Pm-19@gated-at.bofh.it>
	<182Fy-Lx-15@gated-at.bofh.it> <18ajG-4Lz-19@gated-at.bofh.it>
	<18jZB-4VF-19@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Toh <tltoh@attglobal.net> writes:
>
> I can now officially report that the dpt_i2o driver embedded in kernel
> 2.6.0 is broken. I'll highlight and bring this up through my contacts
> back at Adaptec. And hopefully we than can get some kind of official
> resolution soon.

Also the 2.4 dpt_i2o driver is not 64bit clean and doesn't work e.g. 
on AMD64. So in summary it is always pretty broken in all kernels.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUAUIGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 03:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUAUIGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 03:06:49 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:8886 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S263561AbUAUIGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 03:06:48 -0500
Date: Wed, 21 Jan 2004 09:05:11 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Dave Jumpers <david@djdavejumpers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG-Report - ALSA driver in kernel 2.6.1
In-Reply-To: <200401200825.12521.david@djdavejumpers.com>
Message-ID: <Pine.LNX.4.58.0401210902200.2010@pnote.perex-int.cz>
References: <200401200825.12521.david@djdavejumpers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004, Dave Jumpers wrote:

> Device:
> STaudio DSP2000
> 
> Problem:
> All outputs make a rattling noise, peaking to the max levels, with alsa 
> drivers 1.0.1 form kernel 2.6.1
> 
> Steps to reproduce:
> 
> 1) Configure and install alsa drivers form Kernel 2.6.1 for PCI card ice1712
> 2) Play something with aplay, xmms or try run jackd
> 3) observe rattling noise.
> ( Ratling noise pitch increases with sampling frequency.

Can you try alsa-bk-2004-01-20.patch.gz available at 
ftp://ftp.alsa-project.org/pub/kernel-patches ?

It should fix the latest PCI DMA mask changes.

Note that this patch is against 2.6.2-rc1.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

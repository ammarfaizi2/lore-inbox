Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSA0VQK>; Sun, 27 Jan 2002 16:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288686AbSA0VQA>; Sun, 27 Jan 2002 16:16:00 -0500
Received: from zero.tech9.net ([209.61.188.187]:30739 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288685AbSA0VPq>;
	Sun, 27 Jan 2002 16:15:46 -0500
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 27 Jan 2002 16:21:12 -0500
Message-Id: <1012166472.812.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 03:40, Andrew Morton wrote:
> Reading audio from IDE CDROMs always uses PIO.  This patch
> teaches the kernel to use DMA for the CDROMREADAUDIO ioctl.
> [...]
> This code has not been tested for its effects upon SCSI-based
> CDROM readers.  It needs to be.

Andrew,

I wanted to confirm success of testing the patch with a SCSI CD-ROM
(Plextor UltraPlex Wide on aic7xxx).  I used your updated patch off your
website.

Audio rip completed without error.  Performance seems the same, which I
assume is to be expected with SCSI readers.

	Robert Love


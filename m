Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVBPVi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVBPVi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVBPVi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:38:58 -0500
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:32658 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S262050AbVBPVi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:38:56 -0500
From: "Atul Bhouraskar" <atul.bhouraskar@acoustic-technologies.com>
To: "'govind raj'" <agovinda04@hotmail.com>
Cc: "'Linux kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Customized 2.6.10 kernel on a Compact Flash
Date: Thu, 17 Feb 2005 08:39:29 +1100
Message-ID: <002001c5146f$fea2ba90$0d65a8c0@SHARK>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <Pine.LNX.4.61.0502161619330.12007@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of linux-os
> Sent: Thursday, 17 February 2005 08:25
> To: govind raj
> Cc: Linux kernel
> Subject: Re: Customized 2.6.10 kernel on a Compact Flash
> 
> On Thu, 17 Feb 2005, govind raj wrote:
> 
> > Hi all,
> >
> > We are trying to build a customized kernel image from the stable
2.6.10
> > kernel release (in kernel.org). We have not applied any kernel
patches
> on
> > this released version. We are trying to boot this custom image onto
a
> compact
> > flash (from Toshiba) in a embedded board (AMD processor with 64 MB
RAM).
> > While the kernel is coming up during the boot process, it panics and
the
> > console output is as follows:
> >
> [SNIPPED...]
> 
> 
> > Freeing unused kernel memory: 128k freed
> > Kernel panic - not syncing: Attempted to kill init!
> 

Govind,

Try passing init=/bin/bash (or any other shell you might have installed
on your system) to the kernel. This will give you the opportunity to
investigate your problem further.


Atul


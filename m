Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbSI2W0P>; Sun, 29 Sep 2002 18:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbSI2W0O>; Sun, 29 Sep 2002 18:26:14 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:5266 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261826AbSI2W0N>;
	Sun, 29 Sep 2002 18:26:13 -0400
Date: Sun, 29 Sep 2002 23:35:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.39-dj1
Message-ID: <20020929223501.GB7809@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Adrian Bunk <bunk@fs.tum.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020929202416.GA1518@suse.de> <Pine.NEB.4.44.0209292300340.12605-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0209292300340.12605-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 11:02:41PM +0200, Adrian Bunk wrote:

 > it seems there was a problem when generating the patch, the following
 > doesn't seem to be intended (and causes compile errors):
 > --- linux-2.5.39/include/linux/kernel.h 2002-09-27 22:48:34.000000000 +0100
 > +++ linux-2.5/include/linux/kernel.h    1970-01-01 01:00:00.000000000 +0100
 > @@ -1,209 +0,0 @@
 > -#ifndef _LINUX_KERNEL_H
 > -#define _LINUX_KERNEL_H

Indeed. My guess is I missed a bk -r get before doing the diff.
I'll put a -dj2 fixing this and any other missing files later.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

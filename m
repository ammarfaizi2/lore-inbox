Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319058AbSHMSRw>; Tue, 13 Aug 2002 14:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319059AbSHMSRw>; Tue, 13 Aug 2002 14:17:52 -0400
Received: from B5549.pppool.de ([213.7.85.73]:13238 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S319058AbSHMSRt>; Tue, 13 Aug 2002 14:17:49 -0400
Subject: Re: [patch 1/21] random fixes
From: Daniel Egger <degger@fhm.edu>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D5899DB.B087E40D@zip.com.au>
References: <3D56146B.C3CAB5E1@zip.com.au>
	<20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au>
	<20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au>
	<20020813002603.GA20817@www.kroptech.com> <3D5857A4.FE358FA2@zip.com.au>
	<20020813022550.GA6810@www.kroptech.com> <3D587706.A0F2DC21@zip.com.au>
	<20020813041011.GA12227@www.kroptech.com>  <3D5899DB.B087E40D@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 13 Aug 2002 17:39:07 +0200
Message-Id: <1029253148.28098.14.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Die, 2002-08-13 um 07.32 schrieb Andrew Morton:

> > 1m 23s  (I said it was a slow disk ;) 
> gack.  I've seen pencils which can write faster than that.

Interesting. Even up-to-date notebook are not much faster on an ext3 fs:

egger@sonja:/localstuff/temp$ time dd if=/dev/zero of=foo bs=1M
count=600 ; sync 
600+0 Records ein
600+0 Records aus

real    0m58.375s
user    0m0.010s
sys     0m4.930s

> So your wirespeed actually exceeds the disk speed.  That changes things.

This is trivial especially with mainstream machines being shipped with 
GigE.
 
-- 
Servus,
       Daniel


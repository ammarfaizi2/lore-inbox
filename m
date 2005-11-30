Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVK3Ctr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVK3Ctr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVK3Ctr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:49:47 -0500
Received: from CPE-24-31-244-49.kc.res.rr.com ([24.31.244.49]:55450 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1750821AbVK3Ctq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:49:46 -0500
From: Luke-Jr <luke-jr@utopios.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd doesn't replace ide-scsi?
Date: Wed, 30 Nov 2005 02:54:26 +0000
User-Agent: KMail/1.9
References: <200511281218.17141.luke-jr@utopios.org> <58cb370e0511290658m682ae978hea2100f57252a928@mail.gmail.com> <20051129152300.GX15804@suse.de>
In-Reply-To: <20051129152300.GX15804@suse.de>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511300254.27329.luke-jr@utopios.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2005 15:23, Jens Axboe wrote:
> On Tue, Nov 29 2005, Bartlomiej Zolnierkiewicz wrote:
> > > Unfortunately using ide-cd still doesn't have the code set to allow all
> > > burning features to work if you are not root. Even if you have
> > > read+write there's one command you need to do multi-session which is
> > > only allowed to root. Works fine for single sessions, I guess that's
> > > all someone uses.
> >
> > Interesting because both drivers ide-cd and sr+ide-scsi use exactly
> > the same code (block/scsi_ioctl.c) to verify which commands don't
> > need root privileges.  Care to give details?
>
> Not if he is using /dev/sgX with ide-scsi, only SG_IO through /dev/srX
> will go through the block/scsi_ioctl.c path.

Is is possible to get a "IDE generic" device for ide-cdrom? ;)
-- 
Luke-Jr
Developer, Utopios
http://utopios.org/

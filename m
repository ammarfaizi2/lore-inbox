Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262113AbREXPwg>; Thu, 24 May 2001 11:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262114AbREXPw0>; Thu, 24 May 2001 11:52:26 -0400
Received: from geos.coastside.net ([207.213.212.4]:3499 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262113AbREXPwL>; Thu, 24 May 2001 11:52:11 -0400
Mime-Version: 1.0
Message-Id: <p05100302b732dcfd329f@[207.213.214.37]>
In-Reply-To: <20010524121936.I12470@suse.de>
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au>
 <200105240658.f4O6wEWq031945@webber.adilger.int>
 <20010524103145.A9521@gruyere.muc.suse.de> <20010524121936.I12470@suse.de>
Date: Thu, 24 May 2001 08:46:06 -0700
To: Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Dying disk and filesystem choice.
Cc: Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:19 PM +0200 2001-05-24, Jens Axboe wrote:
>In fact you will typically only see an I/O error if the drive _can't_
>remap the sector anymore, because it has run out. No point in reporting
>a condition that was recovered.
>
>I'd still say, that if you get bad block errors reported from your disk
>it's long overdue for replacement.

This can't be right. It implies that the drive is returning bogus 
data with no error indication. Remapping a bad sector is not the same 
as recovering it.
-- 
/Jonathan Lundell.

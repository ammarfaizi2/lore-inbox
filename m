Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSH0QDl>; Tue, 27 Aug 2002 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSH0QDk>; Tue, 27 Aug 2002 12:03:40 -0400
Received: from mail.coastside.net ([207.213.212.6]:59570 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S316491AbSH0QDj>; Tue, 27 Aug 2002 12:03:39 -0400
Mime-Version: 1.0
Message-Id: <p05111a0db99151da8f21@[207.213.214.37]>
In-Reply-To: <1030446205.2539.13.camel@sonja.de.interearth.com>
References: <1030446205.2539.13.camel@sonja.de.interearth.com>
Date: Tue, 27 Aug 2002 09:07:45 -0700
To: Daniel Egger <degger@fhm.edu>, linux kernel <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Two equal harddrives on one cable behaving different
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:03pm +0200 8/27/02, Daniel Egger wrote:
>I'm currently in the process of mirroring a drive with bad sector
>to an equal second one (same modell, same version, same firmware).
>Both of them are on the same cable, the old one as master, the new
>one is slave (now on the outer end of the cable). According to
>smartctl the old one is continously ressolving a couple CRC errors
>per hour while the second one hasn't suffered a single one yet.
>
>(195)Hardware ECC Recovered  0x001a   100   100   000       29678
>few minutes later:
>(195)Hardware ECC Recovered  0x001a   100   100   000       29694
>
>other drive:
>(195)Hardware ECC Recovered  0x001a   100   100   000       0
>
>The cable (80 conductor) seems fine (optically) and I'd wonder if it
>is the culprit because the drive on the outer end (now) works fine.

ECC errors get corrected in the drive, so it would be surprising if 
the cable had an effect. Do you have reason to think that's 
happening? That is, if you swap the drives on the cable, do the 
errors stick with the cable position, or the physical drive? I'd 
expect the latter, and if so would retire the drive.
-- 
/Jonathan Lundell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbTCOVVF>; Sat, 15 Mar 2003 16:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbTCOVVE>; Sat, 15 Mar 2003 16:21:04 -0500
Received: from mail.tammen.info ([62.225.14.106]:26643 "EHLO mail.tammen.de")
	by vger.kernel.org with ESMTP id <S261526AbTCOVVE>;
	Sat, 15 Mar 2003 16:21:04 -0500
From: Heinz Ulrich Stille <ulrich.stille@epost.de>
To: linux-kernel@vger.kernel.org
Subject: Re: dual AMD MP 2000+ and ASUS A7M266-D problems
Date: Sat, 15 Mar 2003 22:31:46 +0100
User-Agent: KMail/1.5
References: <20030314231227.GA19468@maybe.org> <20030315113429.5851f75d.bharada@coral.ocn.ne.jp> <20030315025952.GG19468@maybe.org>
In-Reply-To: <20030315025952.GG19468@maybe.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303152231.46521.ulrich.stille@epost.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 March 2003 03:59, Dale Harris wrote:
> On Sat, Mar 15, 2003 at 11:34:29AM +0900, Bruce Harada elucidated:
> > Have you checked your power supplies?
>
> Well, it's supposed to be a 400W power supply.  But no, I haven't done
> much in that area yet.  I suppose I better get a P3 Kill-A-Watt:

Did you enable "AMD 76x native power management"? Setting CONFIG_AMD_PM768=Y
leads to the results you described for me, among others. (Mainboard is Tyan
S2466, same chipset, AMD-760MPX). Disabling or loading as a module works fine.

Speaking of power: my rig, with 2x Athlon XP 2000+, 1GB of ram, a GF2 GTS and
two hds, draws about 190 watts under full load, somewhat more when the
optical drives are active. But the most I ever registered was 211W (at the
mains level, typical PSU efficiency is around 70%, iirc).

MfG, Ulrich



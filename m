Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264262AbRFIH4d>; Sat, 9 Jun 2001 03:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264270AbRFIH4Y>; Sat, 9 Jun 2001 03:56:24 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13320 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264262AbRFIH4M> convert rfc822-to-8bit; Sat, 9 Jun 2001 03:56:12 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: temperature standard - global config option?
Date: 9 Jun 2001 00:55:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9fskpu$nh6$1@cesium.transmeta.com>
In-Reply-To: <200106082116.f58LGd2497562@saturn.cs.uml.edu> <B7471019.F9CF%bootc@worldnet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id AAA27744
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <B7471019.F9CF%bootc@worldnet.fr>
By author:    Chris Boot <bootc@worldnet.fr>
In newsgroup: linux.dev.kernel
> 
> Well then, tell all the teachers in this world that they're stupid, and tell
> everyone who learnt from them as well.  I'm in high school (gd. 11, junior)
> and my physics teacher is always screaming at us for putting too many
> decimal places or having them inconsistent.  There are certain situations
> where adding a ±1 is too cumbersome and / or clumsy, so you can specify the
> accuracy using just decimal places.
> 

This, again, is a presentation issue, and is irrelevant to the
intricacies of fixed-point arithmetric.

> For example, 5.00 would mean pretty much spot on 5 (anywhere from 4.995 to
> 5.00499), wheras 5 could mean anywhere from 4.5 to 5.499.
> 
> Please, let's quit this dumb argument.  We all know that thermistors and
> other types of cheap temperature gauges are very inaccurate, and I don't
> think expensive thermocouples will make it into computer sensors very soon.
> Plus, who the hell could care whether their chip is at 45.4 or 45.5 degrees?
> Does it really matter?  A difference of 0.1 will not decide whether your
> chip will fry.

Does it really matter NOW?  No.  However, 1 cK is a convenient unit
and a good use of bits.  Can we guarantee it won't matter in the
future, especially not on a CPU which may very well require complex
algorithms to eke out optimal performance in a thermally-challenged
environment (more than just simple trip points.)  Now it gets
interesting!  I have actually seen, in the lab, an algorithm which
required complex guesswork, because it required information below the
noise level of the sensor (and yes, it *is* possible to obtain that
information.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

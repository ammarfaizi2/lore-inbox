Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbTBUOiH>; Fri, 21 Feb 2003 09:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTBUOiH>; Fri, 21 Feb 2003 09:38:07 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:21694 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267456AbTBUOiG>;
	Fri, 21 Feb 2003 09:38:06 -0500
Date: Fri, 21 Feb 2003 14:58:03 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Edward Killips <camber@yakko.cs.wmich.edu>
Cc: Samium Gromoff <deepfire@ibe.miee.ru>, toptan@eunet.eu,
       linux-kernel@vger.kernel.org
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
Message-ID: <20030221145803.GA22285@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Edward Killips <camber@yakko.cs.wmich.edu>,
	Samium Gromoff <deepfire@ibe.miee.ru>, toptan@eunet.eu,
	linux-kernel@vger.kernel.org
References: <20030221122051.20942f70.deepfire@ibe.miee.ru> <Pine.LNX.4.44.0302210926250.8764-100000@yakko.cclub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302210926250.8764-100000@yakko.cclub.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 09:27:55AM -0500, Edward Killips wrote:
 > On my GA-7VAXP (KT400) with an AIW 9700 Pro Radeon the agpgart module 
 > would not load. It could not set the apeture size.

Looks like the backport was based on too early a snapshot.
The via-agp.c in 2.5.62 should work fine.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

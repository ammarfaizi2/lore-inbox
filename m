Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbSLDNB0>; Wed, 4 Dec 2002 08:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSLDNB0>; Wed, 4 Dec 2002 08:01:26 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:49600 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266478AbSLDNB0>;
	Wed, 4 Dec 2002 08:01:26 -0500
Date: Wed, 4 Dec 2002 13:06:22 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Nathaniel Russell <root@chartermi.net>
Cc: reddog83@chartermi.net, linux-kernel@vger.kernel.org
Subject: Re: Help with Via AGP Card
Message-ID: <20021204130622.GF647@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Nathaniel Russell <root@chartermi.net>, reddog83@chartermi.net,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0212032151230.5728-400000@reddog.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212032151230.5728-400000@reddog.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 09:57:56PM -0500, Nathaniel Russell wrote:
 > I have a Via Agp card that reports that it cant be found it i just type in
 > /sbin/modprobe agpgart or /sbin/insmod agpgart
 > but if i do a /sbin/modprobe agpgart agp_try_unsupport=1 or /sbin/insmod
 > agpgart agp_try_unsupported=1 it shows up and works.
 > Some help here plz i would like to just have to type in /sbin/modprobe
 > agpgart but if i cant that would be ok them me.

Simple addition to the "recognised GARTs" table in
drivers/char/agpgart_be.c should do the trick.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

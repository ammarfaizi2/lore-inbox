Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTBUNLA>; Fri, 21 Feb 2003 08:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbTBUNLA>; Fri, 21 Feb 2003 08:11:00 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31933 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267427AbTBUNK7>;
	Fri, 21 Feb 2003 08:10:59 -0500
Date: Fri, 21 Feb 2003 13:32:43 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: toptan@eunet.eu, linux-kernel@vger.kernel.org
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
Message-ID: <20030221133243.GA20044@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Samium Gromoff <deepfire@ibe.miee.ru>, toptan@eunet.eu,
	linux-kernel@vger.kernel.org
References: <20030221122051.20942f70.deepfire@ibe.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221122051.20942f70.deepfire@ibe.miee.ru>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 12:20:51PM +0300, Samium Gromoff wrote:
 > >	GA-7VAXPUltra (KT400)   + ATI Radeon R9000      = passed.
 > >                                                + GeForce 2MX400        = passed.
 > >        Chaintech 7AJA2E (KT133)        + ATI Radeon R9000      = passed.
 > >                                                + GeForce 2MX400        = passed.
 > >
 > >        Abit (i810)                             + ATI Radeon R9000      = passed.
 > >                                                + GeForce 2MX400        = passed.
 > 
 >  From all this hardware only the KT400+R9000 pair possibly engage in AGP8x transfers,
 > and i`m suspicious whether R9000 does it at all...
 > 
 >  So i think somebody testing it on real AGP3.0-capable hardware would do good...

A big issue is that there is no AGP3.0 card currently supported by DRI.
For an AGPx8 test, your only choice seems to be to hack the binary
drivers provided by ATi etc to try and work with the newstyle gart.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbTBUNSQ>; Fri, 21 Feb 2003 08:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTBUNSQ>; Fri, 21 Feb 2003 08:18:16 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:37565 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267430AbTBUNSP>;
	Fri, 21 Feb 2003 08:18:15 -0500
Date: Fri, 21 Feb 2003 13:40:35 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Toplica Tanaskovi?? <toptan@EUnet.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
Message-ID: <20030221134035.GB20044@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Toplica Tanaskovi?? <toptan@EUnet.yu>, linux-kernel@vger.kernel.org
References: <200302210501.21131.toptan@EUnet.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302210501.21131.toptan@EUnet.yu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 05:40:19AM +0100, Toplica Tanaskovi?? wrote:

<hopefully you'll see this on Linux-kernel, as eunet.yu is unresolvable
 here, and I'm getting bounces>

 > 	I am probably wrong, but I think that via-kt400.c in 2.5 is unnecessary, so 
 > I've excluded it from this backport, with some changes in via-agp.c. I did 
 > some tests, but most things are untested due to lack of hardware.

Yes. via-kt400.c was unnecessary (well, it was useful as a standalone
whilst I was developing it) , which was why it was later merged into
via-agp.c in 2.5.60. There were also a bunch of other fixes merged
there, so if you based your backport on an earlier version, I suggest
you grab those changes.
 
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

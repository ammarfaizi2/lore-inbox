Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268417AbTBNOgk>; Fri, 14 Feb 2003 09:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268421AbTBNOgk>; Fri, 14 Feb 2003 09:36:40 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:4008 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268417AbTBNOgj>;
	Fri, 14 Feb 2003 09:36:39 -0500
Date: Fri, 14 Feb 2003 14:41:51 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, Bill Davidsen <davidsen@tmr.com>,
       larry@minfin.bg, linux-kernel@vger.kernel.org
Subject: Re: Strange TCP with 2.5.60
Message-ID: <20030214144151.GA29133@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>, Bill Davidsen <davidsen@tmr.com>,
	larry@minfin.bg, linux-kernel@vger.kernel.org
References: <20030212102418.3a15b4a8.akpm@digeo.com> <Pine.LNX.3.96.1030213182617.13463A-100000@gatekeeper.tmr.com> <20030213153748.1e4df3cc.akpm@digeo.com> <17320000.1045185481@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17320000.1045185481@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > Apparently the problem is that this combined with recent seq_file
 > > conversions has resulted in changed format of some /proc/net/foo files,
 > > which is confusing some network admin apps.
 > > 
 > > It is being worked on.
 > 
 > Can't we do: 
 > 
 > -			if (iter->zone->fz_next)
 > +			/* if (iter->zone->fz_next) */
 > 
 > or something similar? Is much less confusing ...

See "It is being worked on" 8-)
Better to fix it properly..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk

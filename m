Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTAFABG>; Sun, 5 Jan 2003 19:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTAFABG>; Sun, 5 Jan 2003 19:01:06 -0500
Received: from dp.samba.org ([66.70.73.150]:2011 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265517AbTAFAAI>;
	Sun, 5 Jan 2003 19:00:08 -0500
Date: Mon, 6 Jan 2003 11:09:29 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org, orinoco-users@lists.sourceforge.net,
       dhinds@sonic.net
Subject: Re: [Orinoco-users] [PATCH] orinoco_plx-0.13b backport to kernel 2.2
Message-ID: <20030106000929.GC18808@zax.zax>
Mail-Followup-To: Adam Kropelin <akropel1@rochester.rr.com>,
	linux-kernel@vger.kernel.org, orinoco-users@lists.sourceforge.net,
	dhinds@sonic.net
References: <20030105231921.GA7294@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030105231921.GA7294@www.kroptech.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 06:19:21PM -0500, Adam Kropelin wrote:
> I've backported David Gibson's orinoco_plx wireless driver to kernel 2.2.
> The port is based on David Hinds's pcmcia-cs package. I've been running
> various versions of this backport for over a year now and it has been
> working well. I've updated it to the latest (testing, beta) version of
> the orinoco_plx driver (0.13b) and the latest version of pcmcia-cs (3.2.3).
> 
> The patch comes in two parts. The first part updates the version of
> orinoco, hermes, and orinoco_cs modules in pcmcia-cs-3.2.3 from 0.11b to
> 0.13b. The second part adds the backported orinoco_plx module. After
> applying both patches, configure, build, and install pcmcia-cs as normal
> and you should have an additional orinoco_plx.o module ready to use.

Eck... be aware that the "testing" version, although labelled 0.13b
may not be the final 0.13b version.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

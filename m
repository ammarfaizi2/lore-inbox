Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752586AbWAGVEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbWAGVEi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbWAGVEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:04:38 -0500
Received: from mail20.bluewin.ch ([195.186.19.65]:29085 "EHLO
	mail20.bluewin.ch") by vger.kernel.org with ESMTP id S1752586AbWAGVEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:04:36 -0500
Date: Sat, 7 Jan 2006 22:04:17 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.15: via-rhine + link loss + autoneg off == trouble
Message-ID: <20060107210417.GA32681@k3.hellgate.ch>
References: <200601071820.16092.vda@ilport.com.ua> <1136659670.8750.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136659670.8750.14.camel@mindpipe>
X-Operating-System: Linux 2.6.13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Jan 2006 13:47:50 -0500, Lee Revell wrote:
> On Sat, 2006-01-07 at 18:20 +0200, Denis Vlasenko wrote:
> > Hi,
> > 
> > 2.6.15 still exhibits the via rhine "no tx" syndrome.
> 
> Well you didn't cc: the via-rhine maintainer (Roger Luethi), no wonder
> the patch didn't get picked up...

As long as you mention via-rhine, I am going to see it (thanks, procmail).
I don't remember seeing vda post a patch before. First he posted a problem
description, then an analysis (that I commented on), now a patch. Finally,
this is not a via-rhine problem. It's a problem in the mii code and
affects other drivers as well (those that use the generic mii code).

Roger

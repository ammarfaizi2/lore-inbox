Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTBUDPp>; Thu, 20 Feb 2003 22:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbTBUDPp>; Thu, 20 Feb 2003 22:15:45 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:45786 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267083AbTBUDPp>; Thu, 20 Feb 2003 22:15:45 -0500
Date: Fri, 21 Feb 2003 00:25:29 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Andrew Morton <akpm@digeo.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, "" <linux-kernel@vger.kernel.org>,
       "" <lse-tech@lists.sourceforge.net>
Subject: Re: Performance of partial object-based rmap
In-Reply-To: <20030220190819.531e119d.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50L.0302210020560.2329-100000@imladris.surriel.com>
References: <7490000.1045715152@[10.10.2.4]> <278890000.1045791857@flay>
 <20030220190819.531e119d.akpm@digeo.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Andrew Morton wrote:

> I think the guiding principle here is that we should not optimise for the
> uncommon case (as rmap is doing), and we should not allow the uncommon case
> to be utterly terrible (as Dave's patch can do).

This "guiding principle" appears to be the primary reason why
we've taken over a year to stabilise linux 2.0 and linux 2.2
and linux 2.4 ... or at least, too much of a focus on the first
half of this guiding principle. ;)

We absolutely have to take care in avoiding the worst case
scenarios, since statistics pretty much guarantee that somebody
will run into nothing but that scenario ...

cheers,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/

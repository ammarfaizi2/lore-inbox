Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVDAKRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVDAKRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVDAKRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:17:40 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:44194 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262688AbVDAKRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:17:36 -0500
Date: Fri, 1 Apr 2005 12:17:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Roland Dreier <roland@topspin.com>, Yum Rayan <yum.rayan@gmail.com>,
       linux-kernel@vger.kernel.org, mvw@planets.elm.net
Subject: Re: Stack usage tasks
Message-ID: <20050401101723.GA4107@wohnheim.fh-wedel.de>
References: <df35dfeb05033023394170d6cc@mail.gmail.com> <20050331150548.GC19294@wohnheim.fh-wedel.de> <20050331203010.GF3185@stusta.de> <52ll83mtqd.fsf@topspin.com> <20050331211941.GJ3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050331211941.GJ3185@stusta.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 March 2005 23:19:41 +0200, Adrian Bunk wrote:
> 
> Jörn, can you send a list of call paths with a stack usage > 3kB when 
> compiling with gcc 3.4 and unit-at-a-time (or tell me how to generate 
> these lists)?

I'll do a spin over the weekend.

If you want to generate the lists, you can either join IBM, deal with
their lawyers or rewrite the checker [1].

> If fixing a handful of places was sufficient, it was IMHO worth it for 
> enabling unit-at-a-time with gcc 3.4 .

Absolutely.  Even if it required more work, it might be worth it,
eventually.

[1] http://wh.fh-wedel.de/~joern/quality.pdf

Jörn

-- 
I don't understand it. Nobody does.
-- Richard P. Feynman

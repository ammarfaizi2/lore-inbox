Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVDALQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVDALQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 06:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVDALQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 06:16:30 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:51622 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262711AbVDALQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 06:16:27 -0500
Date: Fri, 1 Apr 2005 13:16:22 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Roland Dreier <roland@topspin.com>, Yum Rayan <yum.rayan@gmail.com>,
       linux-kernel@vger.kernel.org, mvw@planets.elm.net
Subject: Re: Stack usage tasks
Message-ID: <20050401111622.GC4107@wohnheim.fh-wedel.de>
References: <df35dfeb05033023394170d6cc@mail.gmail.com> <20050331150548.GC19294@wohnheim.fh-wedel.de> <20050331203010.GF3185@stusta.de> <52ll83mtqd.fsf@topspin.com> <20050331211941.GJ3185@stusta.de> <20050401101723.GA4107@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050401101723.GA4107@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 April 2005 12:17:23 +0200, Jörn Engel wrote:
> On Thu, 31 March 2005 23:19:41 +0200, Adrian Bunk wrote:
> > 
> > Jörn, can you send a list of call paths with a stack usage > 3kB when 
> > compiling with gcc 3.4 and unit-at-a-time (or tell me how to generate 
> > these lists)?
> 
> I'll do a spin over the weekend.

Argl!  No, most likely I won't.  My checker currently depends on
gcc 3.1 (heavily patched).  Porting this to 3.4 or 4.0 is something
I'd like to avoid.  Sparse would be a better target to port to.

In any case, it's nothing to do over the weekend.

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong

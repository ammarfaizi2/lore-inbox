Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSHXMij>; Sat, 24 Aug 2002 08:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSHXMii>; Sat, 24 Aug 2002 08:38:38 -0400
Received: from mail2.alphalink.com.au ([202.161.124.58]:27993 "EHLO
	mail2.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S316070AbSHXMii>; Sat, 24 Aug 2002 08:38:38 -0400
Message-ID: <3D677F8D.F6B62040@alphalink.com.au>
Date: Sat, 24 Aug 2002 22:43:57 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208240059560.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Let me mention (again), that we are talking about two different problems
> here. On the hand bugs in the rulebase can be fixed with either syntax.

Agreed.

> On
> the other hand major cleanups/extensions are better done with only a
> single parser.

>From a purely technical point of view it's easier to extend a single parser
than N.  A single parser is the Obviously Correct Approach (tm).

But the problem is that changing to use a single parser is in itself
a revolutionary step, doubly so if the syntax changes at the same time.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSHOBr6>; Wed, 14 Aug 2002 21:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSHOBr6>; Wed, 14 Aug 2002 21:47:58 -0400
Received: from rj.SGI.COM ([192.82.208.96]:54503 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316430AbSHOBr5>;
	Wed, 14 Aug 2002 21:47:57 -0400
Message-ID: <3D5B0970.13CE831A@alphalink.com.au>
Date: Thu, 15 Aug 2002 11:52:48 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org.com>
CC: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208141242280.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> On Tue, 13 Aug 2002, Peter Samuelson wrote:
> 
> > Mutating the language, long-term, so that it looks less like sh [...]
> 
> That doesn't solve any of the more fundamental problems.

Correct, it doesn't.

> 1) We still have 3 config parsers, which produce slightly different
> .config files.

Yes.

> 2) To integrate a new driver, you have to touch at least 3 files:
> Config.in, Config.help, Makefile. Properly configuring and building a
> driver outside of the tree is painful to impossible.

Yes.

> The problems are really not simple, the current config language is very
> limited, [...]

I don't think anyone who actually understands the config system would
argue these points, but we are limited by practical constraints to making
incremental improvements only.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319146AbSHNASj>; Tue, 13 Aug 2002 20:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319169AbSHNASj>; Tue, 13 Aug 2002 20:18:39 -0400
Received: from rj.sgi.com ([192.82.208.96]:38047 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319146AbSHNASi>;
	Tue, 13 Aug 2002 20:18:38 -0400
Message-ID: <3D59A2DF.3DDA38E8@alphalink.com.au>
Date: Wed, 14 Aug 2002 10:22:55 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org> <3D53D50D.7FA48644@alphalink.com.au> <20020809161046.GB687@cadcamlab.org> <3D579629.32732A73@alphalink.com.au> <20020812154721.GA761@cadcamlab.org> <3D587BA7.1D640926@alphalink.com.au> <20020813180415.B1357@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> On Tue, Aug 13, 2002 at 01:23:19PM +1000, Greg Banks wrote:
> >
> > 977    missing-experimental-tag
> > 113    spurious-experimental-tag
> > 145    variant-experimental-tag
> > 30     inconsistent-experimental-tag
> > 13     missing-obsolete-tag
> > 41     spurious-obsolete-tag
> > 25     variant-obsolete-tag
> How about extending the language (side effect) to automagically append
> (EXPERIMENTAL) or (OBSOLETE) to the menu line, if dependent on
> those special tags?

Yes, this is obviously a good idea, and also it's what CML2 did.
Especially considering that (NEW) is automatically generated, and
(NEW) is not intuitively different from (EXPERIMENTAL) to the lay
user.

The trouble is actually achieving that in shell-based parsers where
shell code cannot tell whether $CONFIG_EXPERIMENTAL has been used in
a condition.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSHORoW>; Thu, 15 Aug 2002 13:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSHORoW>; Thu, 15 Aug 2002 13:44:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56326 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317264AbSHORoV>; Thu, 15 Aug 2002 13:44:21 -0400
Date: Thu, 15 Aug 2002 10:51:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Greg Banks <gnb@alphalink.com.au>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: Get rid of shell based Config.in parsers?
In-Reply-To: <20020814221400.A1562@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0208151048330.3130-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Aug 2002, Sam Ravnborg wrote:
> 
> Where comes the requirement that we shall keep the existing shell 
> based config parsers?

I use them exclusively.

It is far and away the most convenient parsing - just to do "make
oldconfig"  (possibly by making changes by hand to the .config file
first).

As far as I'm personally concerned, the shell parsers are the _only_ 
parser that really matter. So if you want to replace them with something 
else, that something else had better be pretty much perfect and not take 
all that long to build.

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319049AbSHSURJ>; Mon, 19 Aug 2002 16:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319050AbSHSURJ>; Mon, 19 Aug 2002 16:17:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:12038 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S319049AbSHSURJ>;
	Mon, 19 Aug 2002 16:17:09 -0400
Date: Mon, 19 Aug 2002 22:30:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg Banks <gnb@alphalink.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Message-ID: <20020819223044.A1507@mars.ravnborg.org>
Mail-Followup-To: Greg Banks <gnb@alphalink.com.au>,
	Roman Zippel <zippel@linux-m68k.org>,
	Peter Samuelson <peter@cadcamlab.org>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0208161049200.8911-100000@serv> <3D60BA16.38B9CC40@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D60BA16.38B9CC40@alphalink.com.au>; from gnb@alphalink.com.au on Mon, Aug 19, 2002 at 07:27:50PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 07:27:50PM +1000, Greg Banks wrote:
> I'm not optimistic that a switch to a new language or even a new
> parser for the old language will ever happen.
I asked Linus specifically about the replacement of the shell based parsers.
The answer were quite simple:
- It should be convinient to use a new parser.
	- Fast compilation, no errors etc.
It's doable.

> In  http://marc.theaimsgroup.com/?l=linux-kernel&m=101387128818052&w=2
> David Woodhouse gives an idea of what would be necessary to get a new
> language+parser accepted.  Can you achieve that yet?
David suggest to use randomly generated configurations, but they lack
one important feature. They are always valid, and a new system shall be
able to deal with hand-edited .config files in the same way as oldconfig.

	Sam

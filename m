Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSKZTWp>; Tue, 26 Nov 2002 14:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSKZTWo>; Tue, 26 Nov 2002 14:22:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:46095 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266514AbSKZTWo>;
	Tue, 26 Nov 2002 14:22:44 -0500
Date: Tue, 26 Nov 2002 20:29:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kconfig: Locate files relative to $srctree
Message-ID: <20021126192902.GA1525@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20021123220747.GA10411@mars.ravnborg.org> <Pine.LNX.4.44.0211240250490.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211240250490.2113-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman.

On Sun, Nov 24, 2002 at 02:56:22AM +0100, Roman Zippel wrote:
> This is not good. At some point I maybe want to make these configurable.
> I changed the patch to always use zconf_fopen(), which will try the 
> alternative prefix for relative paths.

Sorry for the late feedback, been busy...
I have to say that I like your version better than mine, and it's
actually less intrusive. Thanks for looking into this.

I have tested this patch with objdir in same dir as src, and in
separate dir.
Everything works as usual.

I would be glad if you push this to Linus.

	Sam

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSJITd5>; Wed, 9 Oct 2002 15:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261920AbSJITd5>; Wed, 9 Oct 2002 15:33:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:63247 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261855AbSJITd4>;
	Wed, 9 Oct 2002 15:33:56 -0400
Date: Wed, 9 Oct 2002 21:39:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Peter Samuelson <peter@cadcamlab.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
Message-ID: <20021009213937.A12901@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Peter Samuelson <peter@cadcamlab.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <20021009185203.GK4182@cadcamlab.org> <Pine.LNX.4.33L2.0210091225100.1001-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0210091225100.1001-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Wed, Oct 09, 2002 at 12:28:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 12:28:44PM -0700, Randy.Dunlap wrote:
> 
> The kernel would still have the text-mode configurator.
The way I read the original post by Christoph Hellwig - nope.
If the kernel config library is outside the kernel then the
text-mode versions will fail as well.
Recall that the text-mode version are no longer shell scripts,
but based on a nice YACC grammar and coded in C.

I do not want to go somewhere for special tools just to configure
the kernel.
Basic stuff such as make and gcc is ok to locate elsewhere - in
specific versions as well. But not some basic kernel only configurator.

	Sam

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136165AbRDVPAH>; Sun, 22 Apr 2001 11:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136167AbRDVO76>; Sun, 22 Apr 2001 10:59:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6922 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S136165AbRDVO7i>;
	Sun, 22 Apr 2001 10:59:38 -0400
Date: Sun, 22 Apr 2001 15:59:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010422155923.E20807@flint.arm.linux.org.uk>
In-Reply-To: <20010422131234.B20807@flint.arm.linux.org.uk> <Pine.LNX.4.33.0104221433110.12740-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104221433110.12740-100000@sphinx.mythic-beasts.com>; from matthew@hairy.beasts.org on Sun, Apr 22, 2001 at 02:42:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 02:42:29PM +0100, Matthew Kirkwood wrote:
> On Sun, 22 Apr 2001, Russell King wrote:
> > And what would:
> >
> > C: CONFIG_ARM
> >
> > tell you?  Nothing that is not described in the rest of the "ARM PORT"
> > entry.
> 
> True, but it would tell it to a script without intervention.

I'll grant you that it does solve the "who owns a CONFIG_ symbol", but
that is only one small problem - there's the bigger problem as to who
owns each line of code.  Are we going to start labelling each source
code line as well?

I just don't see what this gets us - its safe to assume that any symbol
in arch/*/config.in which isn't a driver is looked after by the
architecture maintainer.  If not, the architecture maintainer probably
knows who does.

If the purpose of this "documentation" exercise for CONFIG_* symbols
is just that, then shouldn't we be adding it to the Config.in files,
rather than creating yet more files which will become out of sync
with the configuration system?  (maybe we are, but the suggestions
I've seen appear to the contary).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


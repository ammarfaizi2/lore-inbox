Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267709AbTAMBLt>; Sun, 12 Jan 2003 20:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267701AbTAMBLt>; Sun, 12 Jan 2003 20:11:49 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:271 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S267710AbTAMBLo>;
	Sun, 12 Jan 2003 20:11:44 -0500
Date: Mon, 13 Jan 2003 01:20:33 +0000
From: John Levon <levon@movementarian.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make xconfig broken in bk current
Message-ID: <20030113012032.GA73639@compsoc.man.ac.uk>
References: <200301121512.59840.tomlins@cam.org> <20030112203150.GA53199@compsoc.man.ac.uk> <3E2200C6.665A12CA@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2200C6.665A12CA@linux-m68k.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18XtHF-0003ST-00*HXgqxwl5P72*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 12:56:54AM +0100, Roman Zippel wrote:

> > Can I just repeat my request to move this Qt stuff entirely out of the
> > kernel package, where it belongs ?
> 
> We can discuss this during 2.7, until then I prefer to keep it close to
> the kernel, as the config system still has to mature a bit more.

OK, so you're fine with the moving to a different package when the
config library reaches a stable API ? Fair enough.

> > The current detection doesn't even start to get things working
> > correctly.
> 
> For example?

You don't seem to set MOC correctly if you guess a Qt dir. It doesn't
cater for binaries called moc2 or libraries called qt3 or qt2[1]

regards
john

[1] I can't remember if some of these are only present on FreeBSD in
which case it wouldn't be relevant

-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.

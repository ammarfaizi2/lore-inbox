Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbTAZSDr>; Sun, 26 Jan 2003 13:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbTAZSDr>; Sun, 26 Jan 2003 13:03:47 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:56338 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266959AbTAZSDq>;
	Sun, 26 Jan 2003 13:03:46 -0500
Date: Sun, 26 Jan 2003 19:13:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx 6.2.28 and Aic79xx 1.3.0 Released
Message-ID: <20030126181301.GA1065@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <739810000.1043382396@aslan.scsiguy.com> <20030123.202727.102788332.davem@redhat.com> <756820000.1043384077@aslan.scsiguy.com> <20030123.205853.127871890.davem@redhat.com> <20030126170927.GA14059@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030126170927.GA14059@merlin.emma.line.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 06:09:27PM +0100, Matthias Andree wrote:
> Regardless of whether Linus' tree is broken or no, ALWAYS Cc: the fixes
> -- even if trivial -- to the driver maintainer.  It's as simple as that.

That is not how things works out.
Doing trivial changes to 10+ Makefiles does not require to bother
10+ arch maintaners. Same goes for trivial fixes for any subsystem.

Linus pointed out what to do:
Keep a copy of the kernel used for last sync.
Take a copy of latest kernel.
Do a diff of all relevant files, and apply that before submitting.

When it was brought up last time, someone came with a small script to
do so.
No bk magic or other stuff needed, and I see that used by many arch
maintainers - otherwise they would loose to many trivial changes.

	Sam

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSJMPuP>; Sun, 13 Oct 2002 11:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbSJMPuO>; Sun, 13 Oct 2002 11:50:14 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:62732 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261541AbSJMPuO>; Sun, 13 Oct 2002 11:50:14 -0400
Date: Sun, 13 Oct 2002 16:56:01 +0100
From: John Levon <levon@movementarian.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: jcdutton@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: kernel api for application profiling
Message-ID: <20021013155601.GB89058@compsoc.man.ac.uk>
References: <200210131328.PAA14675@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210131328.PAA14675@harpo.it.uu.se>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 03:28:44PM +0200, Mikael Pettersson wrote:

> And before people ask me: perfctr is not yet in official kernels,
> I'm working on a cleaned up version for 2.5 submission RSN,

This is going to clash head-on with oprofile. However, the two systems
are both useful in their own rights: oprofile isn't useful for
interstitial timings as described above, whereas perfctr isn't really
designed for system profiling.

So I suspect the simplest solution would be to make the config options
for them exclusive. Comments ?

regards
john

-- 
"That's just kitten-eating wrong."
	- Richard Henderson

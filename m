Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130871AbRBLNYP>; Mon, 12 Feb 2001 08:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130998AbRBLNYF>; Mon, 12 Feb 2001 08:24:05 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:5951 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S130871AbRBLNXw>; Mon, 12 Feb 2001 08:23:52 -0500
Date: Mon, 12 Feb 2001 15:23:39 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Ivan Borissov Ganev <ganev@cc.gatech.edu>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.[01] lockups
Message-ID: <20010212152339.A11083@niksula.cs.hut.fi>
In-Reply-To: <Pine.LNX.4.20.0102070207300.1226-500000@gamspc7.ihep.su> <Pine.SOL.4.21.0102061907230.7348-100000@tuomotu.cc.gatech.edu> <20010211210219.F3748@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010211210219.F3748@bug.ucw.cz>; from pavel@suse.cz on Sun, Feb 11, 2001 at 09:02:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 09:02:19PM +0100, you [Pavel Machek] claimed:
> Hi!
> 
> > I am experiencing a problem with both 2.4.0 and 2.4.1. The problem is that
> > at seemingly random times the console locks up. After the lockup I can no
> > longer type and the mouse is frozen. As far as I can tell, other systems
> > services are not affected, i.e. programs continue to run, music is being
> > played, I/O is fine. It looks like _only_ the console devices are locked
> > up.
> 
> Login via network or serial cable, and see if /proc/interrupts entry
> for keyboard/mouse changes as you type. Attempt to blink keyboard leds
> with setleds.

Also, try killing gpm.


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

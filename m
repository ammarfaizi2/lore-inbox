Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbQLOKrP>; Fri, 15 Dec 2000 05:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129969AbQLOKqz>; Fri, 15 Dec 2000 05:46:55 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1284 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129953AbQLOKqw>;
	Fri, 15 Dec 2000 05:46:52 -0500
Message-ID: <20001214210245.B468@bug.ucw.cz>
Date: Thu, 14 Dec 2000 21:02:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: Chris Lattner <sabre@nondot.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012132050140.6300-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0012132043350.24483-100000@www.nondot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0012132043350.24483-100000@www.nondot.org>; from Chris Lattner on Wed, Dec 13, 2000 at 08:53:37PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> For one of our demos, we ran a file server on a remote linux box (that we 
> just had a user account on), mounted it on a kORBit'ized box, and ran
> programs on SPARC Solaris that accessed the kORBit'ized linux box's file
> syscalls.  If nothing else, it's pretty nifty what you can do in little
> code...

Cool!

However, can you do one test for me? Do _heavy_ writes on kORBit-ized
box. That might show you some problems. Oh, and try to eat atomic
memory by ping -f kORBit-ized box.

I've always wanted to do this: redirect /dev/dsp from one machine to
another. (Like, I have development machine and old 386. I want all
programs on devel machine use soundcard from 386. Can you do that?)

								Pavel



-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

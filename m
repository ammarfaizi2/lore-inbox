Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278102AbRJ1KD6>; Sun, 28 Oct 2001 05:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278099AbRJ1KDs>; Sun, 28 Oct 2001 05:03:48 -0500
Received: from mailrelay3.inwind.it ([212.141.54.103]:467 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S278103AbRJ1KDf>; Sun, 28 Oct 2001 05:03:35 -0500
Message-Id: <3.0.6.32.20011028110610.01fc3ae0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Sun, 28 Oct 2001 11:06:10 +0100
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: more devfs fun (Piled Higher and Deeper)
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
In-Reply-To: <Pine.GSO.4.21.0110271536190.21545-100000@weyl.math.psu.edu
 >
In-Reply-To: <Pine.GSO.4.21.0110271513580.21545-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15.50 27/10/01 -0400, Alexander Viro wrote:
>/me _seriously_ considers hostile takeover of the damn thing
>
>I mean, when holes are found at that rate just by cursory look through
>the code...  And that stuff had been there for at least 2 years.
>Richard, I hate to break it on you, but dealing with that crap is
>generally considered a maintainer's job.  And it is supposed to happen
>slightly faster - 2 years would be bad even for MS.  If you don't
>have time for that work - say so and step down, nobody will blame
>you for that.  Repeating that everything will be fine RSN is getting
>real old by now...

As matters stand I would suggest a radical approach:
What about to replace the current devfs by a clean and lightweight
ramfs based filesystem?
IMO we need a complete rewrite and I'm sure we can make it simpler
and cleaner. 2.5 stuff, but it's worthwhile.

Just my 0.02 Euro,


-- 
Lorenzo

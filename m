Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157366AbPJWN3a>; Sat, 23 Oct 1999 09:29:30 -0400
Received: by vger.rutgers.edu id <S157358AbPJWNTz>; Sat, 23 Oct 1999 09:19:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27756 "EHLO atrey.karlin.mff.cuni.cz") by vger.rutgers.edu with ESMTP id <S157383AbPJWNBX>; Sat, 23 Oct 1999 09:01:23 -0400
Message-ID: <19991016235253.D201@bug.ucw.cz>
Date: Sat, 16 Oct 1999 23:52:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Tom M. Kroeger" <tmk@cse.ucsc.edu>, Drew Bernat <abernat@zathras.net>, linux-kernel@vger.rutgers.edu
Subject: Re: Advice wanted: WebFS term project
References: <Pine.GSO.4.10.9910121234280.22333-100000@weyl.math.psu.edu> <a4zoxjt7ck.fsf@gilgamesh.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <a4zoxjt7ck.fsf@gilgamesh.cse.ucsc.edu>; from Tom M. Kroeger on Sat, Oct 16, 1999 at 12:48:27PM -0700
Sender: owner-linux-kernel@vger.rutgers.edu

Hi!

> What I'd like to see instead of http and ftp is a file-system that
> uses scp & ssh as the transport.  It would be a secure method to mount
> remote files on machines that you don't have root access on.

You want to see combination of mc and podfuk. We already do file
transport over ssh. Yes, with podfuk it acts like
userfs. http://atrey.karlin.mff.cuni.cz/~pavel/podfuk/podfuk.html. [We
do not actually use scp; ssh is just enough: we upload "programs" to
the server, dd is required on remote side. Look at mc/vfs/fish.c.]

								Pavel
PS: userfs is dead. Podfuk is trying to be replacement. Improving
midnight is the right way.
-- 
I'm really pavel@ucw.cz. Look at http://195.113.31.123/~pavel.  Pavel
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

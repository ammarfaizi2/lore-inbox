Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbRAPXNX>; Tue, 16 Jan 2001 18:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132600AbRAPXNO>; Tue, 16 Jan 2001 18:13:14 -0500
Received: from palrel3.hp.com ([156.153.255.226]:37650 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S132416AbRAPXNI>;
	Tue, 16 Jan 2001 18:13:08 -0500
Message-ID: <3A64D582.6CFB35D@cup.hp.com>
Date: Tue, 16 Jan 2001 15:13:06 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Is sendfile all that sexy? (fwd)]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> : >Agreed -- the hard-coded Nagle algorithm makes no sense these days.
> :
> : The fact I dislike about the HP-UX implementation is that it is so
> : _obviously_ stupid.
> :
> : And I have to say that I absolutely despise the BSD people.  They did
> : sendfile() after both Linux and HP-UX had done it, and they must have
> : known about both implementations.  And they chose the HP-UX braindamage,
> : and even brag about the fact that they were stupid and didn't understand
> : TCP_CORK (they don't say so in those exact words, of course - they just
> : show that they were stupid and clueless by the things they brag about).
> :
> : Oh, well. Not everybody can be as goodlooking as me. It's a curse.

nor it would seem, as humble :)

Hello Linus, my name is Rick Jones. I am the person at Hewlett-Packard
who drafted the "so _obviously_ stupid" sendfile() interface of HP-UX.
Some of your critique (quoted above) found its way to my inbox and I
thought I would introduce myself to you to give you an opportunity to
expand a bit on your criticism. In return, if you like, I would be more
than happy to describe a bit of the history of sendfile() on HP-UX.
Perhaps (though I cannot say with any certainty) it will help explain
why HP-UX sendfile() is spec'd the way it is.

rick jones
never forget what leads to the downfall of the protagonist in Greek
tragedy...

-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLNSHR>; Thu, 14 Dec 2000 13:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQLNSHK>; Thu, 14 Dec 2000 13:07:10 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:64518 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S129524AbQLNSG4>;
	Thu, 14 Dec 2000 13:06:56 -0500
Date: Thu, 14 Dec 2000 11:37:11 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <E146VJz-00044N-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012141135100.26708-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Of course.  Which is why CORBA is about putting STRUCTURE in that stream
> > of random bytes coming over the wire.  Why should I have to rewrite my
> > marshalling and demarshalling code every time I want to write a
> > server.  read and write are fine.  But sometimes I want a
> > structure.  Sometimes, my structures aren't laid out like C struct's
> > either.  What then?  What if I want to send an "object" to you?
> 
> Then I need to understand the object anyway. And Corba objects are horribly
> over complex. Any lisp hacker will tell you there is only one type: a list.

But alan, that's the beautiful thing.  Given a CORBA object, you can
understand its structure without knowing exactly what the contents
are.  You can effectively derive it's prototype just by inspecting it.

The only difference between lisp and a CORBA object in this respect is
that each item in the list is typed so that you have even more info about
what to do with it.  :)

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

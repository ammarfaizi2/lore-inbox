Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbQLNMSW>; Thu, 14 Dec 2000 07:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbQLNMSN>; Thu, 14 Dec 2000 07:18:13 -0500
Received: from verisity41.verisity.com ([216.216.10.41]:15593 "EHLO
	verisity.com") by vger.kernel.org with ESMTP id <S130356AbQLNMSC>;
	Thu, 14 Dec 2000 07:18:02 -0500
From: Michael Livshin <mlivshin@bigfoot.com>
To: orbit-list@gnome.org
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012132106070.24665-100000@www.nondot.org>
Organization: the Church of God the Utterly Indifferent
In-Reply-To: Chris Lattner's message of "Wed, 13 Dec 2000 21:12:05 -0600 (CST)"
Date: 14 Dec 2000 13:46:57 +0200
Message-ID: <s3r93bb4y6.fsf@bigfoot.com.cmm>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lattner <sabre@nondot.org> writes:

> > p9fs exists.  I didn't see these patches since August, but probably I can poke
> > Roman into porting it to the current tree.  9P is quite simple and unlike
> > CORBA it had been designed for taking kernel stuff to userland.  Besides,
> > authors definitely understand UNIX...
> 
> One thing that you might want to mention Alexander: 9P is not a general
> communications protocol.  In fact, it doesn't work very well across the
> internet at all.  To get decent performance, the Plan9 group (which, is a
> very cool group.  :) has to specify a new protocol that competes with TCP
> on the level of complexity (IL: http://plan9.bell-labs.com/sys/doc/il/il.html)

this might be because the Bell Labs folks don't like RPC in general
when network latencies become involved?  I'm guessing.

'cause CORBA is still pretty much objectified RPC, as far as I know.
I don't think you want to abstract the network out just like that when 
dealing with kernels.

-- 
Entropy isn't what it used to be.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

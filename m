Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293301AbSBYCto>; Sun, 24 Feb 2002 21:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291613AbSBYCte>; Sun, 24 Feb 2002 21:49:34 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:4873 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293301AbSBYCtX>; Sun, 24 Feb 2002 21:49:23 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, mingo@elte.hu,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: your mail 
In-Reply-To: Your message of "Sun, 24 Feb 2002 20:58:49 CDT."
             <Pine.GSO.4.21.0202242054410.1329-100000@weyl.math.psu.edu> 
Date: Mon, 25 Feb 2002 13:14:29 +1100
Message-Id: <E16fAer-0000vA-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.21.0202242054410.1329-100000@weyl.math.psu.edu> you writ
e:
> 
> 
> On Mon, 25 Feb 2002, Rusty Russell wrote:
> > First, fd passing sucks: you can't leave an fd somewhere and wait for
> > someone to pick it up, and they vanish when you exit.  Secondly, you
> 
> Yes, you can.  Please, RTFS - what is passed is not a descriptor, it's
> struct file *.  As soon as datagram is sent, descriptors are resolved and
> after that point descriptor table of sender (or, for that matter, survival
> of sender) doesn't matter.

Please explain how I leave a fd somewhere for other processes to grab
it.  

And then please explain how they get the fd after I've exited.

Al, you are one of the most unpleasant people to deal with on this
list.  This is *not* an honor, and I beg you to consider a different
approach in future correspondence.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

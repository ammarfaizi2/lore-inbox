Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274653AbRJNHTL>; Sun, 14 Oct 2001 03:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274666AbRJNHS7>; Sun, 14 Oct 2001 03:18:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13721 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274653AbRJNHS4>; Sun, 14 Oct 2001 03:18:56 -0400
Date: Sun, 14 Oct 2001 12:55:01 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011014125501.A9354@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com> <Pine.LNX.4.33.0110131024480.8707-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0110131024480.8707-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Oct 13, 2001 at 10:28:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 10:28:13AM -0700, Linus Torvalds wrote:
> 
> On Sat, 13 Oct 2001, Linus Torvalds wrote:
> >
> > In short, RCU seems to be a case of "hey, that's cool", but it's a
> > solution in search of a problem so severe that it is worth it.
> 
> Oh, and before people start telling me that RCU was successfully used in
> AIX/projectX/xxxx/etc, you have to realize that I don't give a rats *ss
> about the fact that there are OS's out there that are "more scalable".

Absolutely. Those are different OSes, different environments and mostly
imprtantly different goals. We may draw on that experience, but still
need to prove that the ideas work for *Linux*.

> 
> The last time I looked, Solaris and AIX and all the rest of the "scalable"
> systems were absolute pigs on smaller hardware, and the "scalability" in
> them often translates into "we scale linearly to many CPU's by being
> really bad even on one".

No argument here at all. Big iron is only a part of what linux
does and we are very conscious of that fact. In fact, this makes
our work quite an interesting challenge.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

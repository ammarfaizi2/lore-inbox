Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284927AbRLKIj7>; Tue, 11 Dec 2001 03:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284926AbRLKIjt>; Tue, 11 Dec 2001 03:39:49 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:24583 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S284927AbRLKIjk>;
	Tue, 11 Dec 2001 03:39:40 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112110839.fBB8dFB257403@saturn.cs.uml.edu>
Subject: Re: Linux/Pro  -- clusters
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 11 Dec 2001 03:39:15 -0500 (EST)
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0112101136490.14238-100000@binet.math.psu.edu> from "Alexander Viro" at Dec 10, 2001 11:49:36 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> Basically you propose to take the current system, replace it with
> something without clear memory management ("let it leak") and then
> try to fix the resulting mess.
> 
> I would rather switch code that uses kdev_t to use of dynamically
> allocated structures.  Subsystem-by-subsystem.  Keeping decent
> memory management on every step.
> 
> It's _way_ easier than trying to fix leaks and dangling pointers in
> the fuzzy code we'd get with your approach.  Just look at the fun
> Richard has with devfs right now.

Leaks go away if you add a garbage collector. To get rid of the
dangling pointers, write this part of the kernel in Java or LISP.
There's an OS called emacs that was done this way, and even has
a LISP engine under the GPL. Grab that code maybe.






















>:-)

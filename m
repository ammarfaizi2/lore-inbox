Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSKCQ47>; Sun, 3 Nov 2002 11:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSKCQ47>; Sun, 3 Nov 2002 11:56:59 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:10567 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262190AbSKCQ46>; Sun, 3 Nov 2002 11:56:58 -0500
Date: Sun, 3 Nov 2002 09:08:16 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bill Davidsen <davidsen@tmr.com>, Steven King <sxking@qwest.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: [lkcd-general] Re: What's left over.
In-Reply-To: <1036341175.29646.49.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211030906210.30732-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Nov 2002, Alan Cox wrote:
|>Encrypting the dump with the new crypto lib in the kernel would be easy,
|>right now it doesnt. 

Piece of cake.  It's like adding a dump compression module.  You
can load dump_gzip.o or dump_rle.o to specify the kind of compression
you want to use.  dump_crypto.o would be the same kind of thing.  Just
add another flag and away you go.

|>My disk dump concerns are purely those of correctness. That means
|>
|> [ ... ]
|>
|>Most of the pieces already exist.

It's just a matter of time, then.

--Matt


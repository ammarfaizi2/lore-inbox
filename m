Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRA0EMk>; Fri, 26 Jan 2001 23:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129334AbRA0EMa>; Fri, 26 Jan 2001 23:12:30 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:5729 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id <S129051AbRA0EMP>; Fri, 26 Jan 2001 23:12:15 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: hotmail not dealing with ECN
Date: 27 Jan 2001 04:10:48 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <94tho8$627$1@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com> <14960.56461.296642.488513@pizda.ninka.net> <3A70DDC4.6D1DB1EC@transmeta.com> <3A713B3F.24AC9C35@idb.hist.no>
Reply-To: daw@cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting  wrote:
>So, no reason for a firewall author to check these bits.

You don't think like a firewall designer! :-)

Practice being really, really paranoid.  Think: You're designing a
firewall; you've got some reserved bits, currently unused; any future code
that uses them could behave in completely arbitrary and insecure ways,
for all you know.  Now recall that anything not known to be safe should
be denied (in a good firewall) -- see Cheswick and Bellovin for why.
When you take this point of view, it is completely understandable why
firewalls designed before ECN was introduced might block it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

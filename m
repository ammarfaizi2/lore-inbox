Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbTLFUMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbTLFUMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 15:12:55 -0500
Received: from rly-ip05.mx.aol.com ([64.12.138.9]:36066 "EHLO
	rly-ip05.mx.aol.com") by vger.kernel.org with ESMTP id S265244AbTLFUMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 15:12:51 -0500
Date: Sat, 6 Dec 2003 12:56:04 -0700
Subject: Re: partially encrypted filesystem
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       willy@debian.org, ezk@cs.sunysb.edu, joern@wohnheim.fh-wedel.de,
       phillip@lougher.demon.co.uk, kbiswas@neoscale.com
To: maze@cela.pl, valdis.kletnieks@vt.edu
From: Pat LaVarre <p.lavarre@ieee.org>
Content-Transfer-Encoding: 7bit
Message-Id: <39B8D78E-2826-11D8-8D5E-000393A22C62@ieee.org>
X-Mailer: Apple Mail (2.553)
X-Apparently-From: PPAATT@aol.com
X-AOL-IP: 198.81.18.131
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > Suppose we wish to encrypt the files on a
 > > disc or disk or drive that we carry from one
 > > computer to another.
 > >
 > > Where else can the encryption go, if not
 > > "down to the file system"?
 >
 > From: ...maze...
 > ... sparse feature... of the filesystem ...
 > ways for which it likely wasn't designed,
 > thus ... likely ... problems ... slowdowns ...
 > sparse .... seldom used ... mostly ... static ...
 > later write access ... better or worse .... fragmentations ...
 > may ... required ... significant ... making ... work _well_

Agreed.

 > some other method ....
 > less likely to cause massive disk fragmentation.

Such as?

 > From: ...valdis...
 > ... Other ... theoretically ... if not totally workable.

Aye personally I focus on workable application of theory.

 > above ... a la PGP ...

Aye I see "compressed folders" arriving on desktops, and I see 
commercial encryption using that same approach.

 > below ... a la encrypted loopback ....

I'm guessing encryption raises many/all the same issues as compression.

Frustratingly, I find I can't quite lay hold of why people haven't more 
widely adopted compression/ encryption in random-access storage.

Personally I mostly ignored storage until 1994, then I dug in, then I 
felt most shocked to discover nothing like modem compression deployed, 
not even compression for each concentric track of an HDD.  Conceptually 
I like e.g. Usenix talk re garbage-collected log-structured 
filesystems, but nobody's made those real, I'm not yet clear why.

I want compression to trade away time for space, to mess with the 
phenomenon of people living all life at 95% of quota, and to contradict 
the theory that no fs works well when more than 50% full.

Pat LaVarre

P.S. Maybe my second deepest culture shock was finding max bytes/cdb 
choked off near zero e.g. 64 KiB in many places, 128 KiB now rumoured 
for parts of lk 2.6.  I'm not sure how often quantitative measurements 
of algorithms wrongly show no improvement because swamped by that limit.


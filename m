Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSGYD5I>; Wed, 24 Jul 2002 23:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317211AbSGYD5I>; Wed, 24 Jul 2002 23:57:08 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2]:55263 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id <S317112AbSGYD5I>; Wed, 24 Jul 2002 23:57:08 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
References: <Pine.GSO.4.21.0207241925450.14656-100000@weyl.math.psu.edu>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: 24 Jul 2002 23:00:21 -0500
In-Reply-To: Alexander Viro's message of "Wed, 24 Jul 2002 19:42:41 -0400 (EDT)"
Message-ID: <ufaznwg319m.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AV" == Alexander Viro <viro@math.psu.edu> writes:

AV> That stuff becomes an issue for 2Tb disks.  Do we actually have
AV> something that large attached to 32bit boxen?

Yes, I just built a few machines with 2.2TB of disk apiece.  And this
isn't really all that esoteric; each box only cost around $7K.

AV> ... and still use i386 with these disks?  ia64 is stillborn, but
AV> x86-64 promises to be more useful than Itanic.

Well, these are just file servers.  It would be a waste to stick a
64bit processor in there just for its 64bitness; if I could get
Hammers, I'd rather run compute jobs on them and leave the menial
tasks like file serving to the 32bit machines.

AV> u64 for sector_t doesn't change anything for 64bit boxen that
AV> might be interested in really large disks and screws 32bit ones
AV> that shouldn't have to pay for that...

Well, I'd happily run a custom kernel on these machines.  I certainly
don't want my other hundred-plus machines to run slower just to let a
handful of file servers see all of their disk, but it would be nice to
have the choice.

 - J<


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283245AbRLHSDm>; Sat, 8 Dec 2001 13:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283668AbRLHSDW>; Sat, 8 Dec 2001 13:03:22 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:10256
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S283245AbRLHSCE>; Sat, 8 Dec 2001 13:02:04 -0500
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and
	benchmarks
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Ragnar =?ISO-8859-1?Q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>,
        Hans Reiser <reiser@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        reiserfs-dev@namesys.com
In-Reply-To: <E16CNHk-0000u4-00@starship.berlin>
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin>
	<3C0EE8DD.3080108@namesys.com> <20011206122753.A9253@vestdata.no> 
	<E16CNHk-0000u4-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 08 Dec 2001 10:02:02 -0800
Message-Id: <1007834523.2566.2.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 07:51, Daniel Phillips wrote:
> I did try R5 in htree, and at least a dozen other hashes.  R5 was the worst 
> of the bunch, in terms of uniformity of distribution, and caused a measurable 
> slowdown in Htree performance.  (Not an order of magnitude, mind you, 
> something closer to 15%.)

Did you try the ReiserFS teahash?  I wrote it specifically to address
the issue you mentioned in the paper of an attacker deliberately
generating collisions; the intention was that each directory (or maybe
filesystem) have its own distinct hashing key.

	J


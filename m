Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOBJj>; Thu, 14 Dec 2000 20:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOBJ3>; Thu, 14 Dec 2000 20:09:29 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:25352 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129267AbQLOBJW>; Thu, 14 Dec 2000 20:09:22 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Linus's include file strategy redux
Date: 15 Dec 2000 00:39:05 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <91bp79$1iv$1@enterprise.cistron.net>
In-Reply-To: <91bnoc$vij$2@enterprise.cistron.net> <Pine.GSO.4.21.0012141916270.10441-100000@weyl.math.psu.edu>
X-Trace: enterprise.cistron.net 976840745 1631 195.64.65.67 (15 Dec 2000 00:39:05 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0012141916270.10441-100000@weyl.math.psu.edu>,
Alexander Viro  <viro@math.psu.edu> wrote:
>On 15 Dec 2000, Miquel van Smoorenburg wrote:
>
>> In article <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com>,
>> LA Walsh <law@sgi.com> wrote:
>> >Which works because in a normal compile environment they have /usr/include
>> >in their include path and /usr/include/linux points to the directory
>> >under /usr/src/linux/include.
>> 
>> No, that a redhat-ism.
>
>Not even all versions of redhat do that.

If that has been fixed recently, that is a very Good Thing (tm).

Now if in 2.5 <kernel>/include/net would be moved to <kernel>/linux/net
so that user-level code that uses <net/whatever.h> can be compiled
with -I/usr/src/some/kernel/42.42/include/ I'd be even happier

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

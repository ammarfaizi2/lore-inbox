Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265476AbSKABV5>; Thu, 31 Oct 2002 20:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265557AbSKABVg>; Thu, 31 Oct 2002 20:21:36 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:28230 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265570AbSKABUx>; Thu, 31 Oct 2002 20:20:53 -0500
Date: Thu, 31 Oct 2002 17:35:28 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <3DC19A4C.40908@pobox.com>
Message-ID: <Pine.LNX.4.44.0210311732110.23393-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Jeff Garzik wrote:
|>Linus Torvalds wrote:
|>[yes, I realize the LKCD merge debate is over, bear with me :)]

For Linus, it is.

|>That said, I used to be an LKCD cheerleader until a couple people made 
|>some good points to me:  it is not nearly low-level enough to truly be 
|>of use in crash situations.  netdump can work if your interrupts are 
|>hosed/screaming, and various mid-layers are dying.  For LKCD to be of 
|>any use, it needs to _skip_ the block layer and talk directly to 
|>low-level drivers.

Just to clarify, LKCD is NOT block based dumping, OR net based
dumping, or anything.  It's an infrastructure for dumping that
lets you, the user, the distributor, the customer, whatever,
make the decision for what's right for you.  Yes, we provide
disk based dumping now, and are including the net dump code
very soon, as well as some of these other smaller dump methods.

Has ANYONE other than Christoph and Stephen H. done a full review of
the LKCD patch set before commenting?  Or are people just making
this stuff up as they go along?  A ton of things have changed
over the past year just because people complained about only doing
disk dumping.  And then to hear this ...

|>So, I think the stock kernel does need some form of disk dumping, 
|>regardless of any presence/absence of netdump.  But LKCD isn't
|>there yet...

Please read the patches and decide again.  If you want the latest
net dump patch, let me know.

|>    Jeff

--Matt


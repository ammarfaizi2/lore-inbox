Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265261AbSKABrZ>; Thu, 31 Oct 2002 20:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSKABrZ>; Thu, 31 Oct 2002 20:47:25 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:32326 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265261AbSKABrY>; Thu, 31 Oct 2002 20:47:24 -0500
Date: Thu, 31 Oct 2002 18:01:12 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Shawn <core@enodev.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <20021031162026.A12486@q.mn.rr.com>
Message-ID: <Pine.LNX.4.44.0210311737020.23393-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Shawn wrote:
|>On 10/31, Matt D. Robinson said something like:
|>> On Thu, 31 Oct 2002, Linus Torvalds wrote:
|>> |>On Wed, 30 Oct 2002, Matt D. Robinson wrote:
|>> |>That's fine. And since they are paid to support it, they can apply the 
|>> |>patches.  
|>> 
|>> We want to see this in the kernel, frankly, because it's a pain
|>> in the butt keeping up with your kernel revisions and everything
|>> else that goes in that changes.  And I'm sure SuSE, UnitedLinux and
|>> (hopefully) Red Hat don't want to spend their time having to roll
|>> this stuff in each and every time you roll a new kernel.
|>
|>I share some of your sentiment, but honestly, think about it.
|>
|>Linus has to "keep up" with all the changees coming into his inbox as
|>well, and the more features, the more breakage that can happen when
|>Linus accepts a patch.

Uh ... have you read the patches?  Do you see how few the
changes are to non-dump code?  Do you know that most of those
changes only get triggered in a crash situation anyway?

Breakage occurs when people change code areas that are used
all the time, like VM, network, block layer, etc.

Look at the patches and tell me where we are causing overhead
and and seriously potential breakage.  If you find problems,
then tell us, don't just comment on breakage scenarios.

|>Really, Linus wants to push some of his maintanance overhead to distros,
|>who get paid to do it, but also to provide sexy bullet point items for
|>users, so they buy "Linux" stuff.

Sure, then remove all of the extra filesystems, sound drivers,
etc., that are bulking up the kernel distribution now and give
them to the distributors to include.

|>You try to find a better balance.

If I could think of a better balance to ease his load, I would.
He's already made his mind up.  It doesn't mean it won't end up
merged by someone else (or everyone else for that matter).

--Matt


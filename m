Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269333AbRGaPwM>; Tue, 31 Jul 2001 11:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269332AbRGaPvy>; Tue, 31 Jul 2001 11:51:54 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:49162 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S269331AbRGaPvt>; Tue, 31 Jul 2001 11:51:49 -0400
Date: Tue, 31 Jul 2001 08:51:43 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Justin Guyett <justin@soze.net>
cc: <Tony.Lill@ajlc.waterloo.on.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: laptops and journalling filesystems
In-Reply-To: <Pine.LNX.4.33.0107302222000.8520-100000@kobayashi.soze.net>
Message-ID: <Pine.LNX.4.33.0107310843560.6094-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Justin Guyett wrote:

> On Mon, 30 Jul 2001, Tony Lill wrote:
>
> > Do any of the current batch of journalling filesystems NOT diddle the
> > disk every 5 seconds? I've tried reiser and ext3 and they're both
> > antithetic to spinning down the disk. Any plans to fix this bug in
> > future kernels?
>
> are you sure this is a product of the journal and not the vm?  a machine
> with 1gig memory doing nothing (<25% physmem used) and ext2 has disk
> accesses ever few minutes too.

that's not my experience.  i use noatime, i've disabled atd and selected
crontab entries, and i've got enough RAM to avoid paging.  the disk will
stay spinned down for hours (usually until i touch netscape).  the system
is based on redhat 6.1 (2.2 kernel).

-dean


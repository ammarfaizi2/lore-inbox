Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266386AbSKLJgT>; Tue, 12 Nov 2002 04:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266389AbSKLJgT>; Tue, 12 Nov 2002 04:36:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62375 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266386AbSKLJgS>;
	Tue, 12 Nov 2002 04:36:18 -0500
Date: Tue, 12 Nov 2002 04:43:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Ryan Anderson <ryan@michonline.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs API
In-Reply-To: <20021112080417.GA11660@think.thunk.org>
Message-ID: <Pine.GSO.4.21.0211120410130.29617-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Nov 2002, Theodore Ts'o wrote:

> In any case, if there aren't all that many people using devfs, I can
> think of a really easy way in which we could simplify and clean up its
> API by slimming it down by 100%......

Well.  If Linus decides to remove devfs, I certainly won't weep for it.
However, I don't see any signs of that happening right now, and cleaned
interface is less PITA than what we have in the current tree.  Right now
I'm mostly interested in making the glue in drivers simpler and less
intrusive.  The fact that it leads to less/simpler code in devfs proper
is also a Good Thing(tm)...


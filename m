Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbTCLSVW>; Wed, 12 Mar 2003 13:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261841AbTCLSVW>; Wed, 12 Mar 2003 13:21:22 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:32827 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S261835AbTCLSVU>; Wed, 12 Mar 2003 13:21:20 -0500
Date: Wed, 12 Mar 2003 19:25:01 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <20030312085032.7d536566.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.30.0303121833530.18833-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Randy.Dunlap wrote:
>
> Not quite what you describe, but the in-kernel-config (ikconfig) patch by
> me & some HP folks saves a "built-with" string along with the .config file
> (as a CONFIG option, of course).

>From a bit different point of view and in general this is much better.

> | BTW, if possible having the Code both before and after when a fault
> | happens could also help a lot in the future.
>
> Do you just mean more opcode decoding?

The Code part of the Oops shows what's after EIP (i386). It's also
important (if not more) what's before. I fail to see the difficulties
to add this feature (or was it dropped?), ksymoops should handle it.

Real world example: I've spent 2 days trying to find a kernel
configuration that both builds and works (ordinary hardware and I'm
using Linux for 8 years) then 3 days waiting for data I asked for. If
the above info was in Oops it could be told immediately with very high
probability by somebody who knew already about this compiler bug.

	Szaka


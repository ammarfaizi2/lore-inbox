Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVEGSKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVEGSKP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 14:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVEGSKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 14:10:15 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:18319 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262740AbVEGSJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 14:09:46 -0400
Date: Sat, 7 May 2005 14:05:45 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Stefan Smietanowski <stesmi@stesmi.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo format - arch dependent!
In-Reply-To: <427D000B.40803@stesmi.com>
Message-ID: <Pine.GSO.4.33.0505071351360.19035-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2005, Stefan Smietanowski wrote:
>> Back when I first brought this up (8 years ago?), it was simple... numcpu
>> was it.  There weren't any virtual processors or multi-core critters.

... as far as linux was concerned, which is the whole point.  We aren't
talking about those ancient cray's and other oddball (by modern definition)
quad 386's -- yes, I've seen one of those; yes, it was more dust than
actual computer :-)

>Pretty big generalization there. But tell me, a HT DualCore CPU - how
>DO you think it should end up being visible?

One has to make generalizations.  I'm not typin' for days here.

Your HT DC CPU counts as 4 cpus total... the same as two HT processors.
The system does not fundamentally need to make a distinction on dual core
vs. two actual chips + heat sinks + fans.  The system will perform almost
identically (if not acutally identically) to a dual (single core) processor
system.

>Also, remember the some database vendors have said that they will charge
>per cpu package and some have said it's per cpu core.

That's between you and the licensor.  Some count virtual processors, some
count logical processors, and I'm sure there are some that are worded
based on the physical number of processor chips (even if they aren't online.)
But I don't pander to the greedy bastard database vendors :-)  "I swear
we're only running Oracle on *one* of the 8 processors.  Honest."
(you can never satisfy everyone all of the time.)

Personally, I don't count HT as a "second processor"... because it's not.

--Ricky



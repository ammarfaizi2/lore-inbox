Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbTCNK54>; Fri, 14 Mar 2003 05:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261697AbTCNK54>; Fri, 14 Mar 2003 05:57:56 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:26995 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S261683AbTCNK5z>; Fri, 14 Mar 2003 05:57:55 -0500
Date: Fri, 14 Mar 2003 12:02:24 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <3E71A838.9020306@aitel.hist.no>
Message-ID: <Pine.LNX.4.30.0303141113330.25220-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Mar 2003, Helge Hafting wrote:

> The problem is that several offsets will fit into this.  Going
> backwards

You never ever go backwards. It's impossible. You always go ahead.
Even if you want to disassemble backwards you go ahead. How? You start
earlier but you must do it in a very limited times (compared to the
number of variations going backwards) with different offsets.

> > 	2) has something to do with the C source code
> And how do you plan on achieving that?  This one is

Manual investigation. I don't expect the kernel starts dumping the
"before code" at the correct instruction boundary even if Jonathan's
idea/code sounds brilliant to do so (I didn't check it).

What I tried to ask is purely just reading and dumping some bytes
before EIP also for postmortem analyses. That's all, nothing
complicated.

	Szaka


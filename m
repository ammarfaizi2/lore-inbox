Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbTA2M01>; Wed, 29 Jan 2003 07:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTA2M00>; Wed, 29 Jan 2003 07:26:26 -0500
Received: from ns.suse.de ([213.95.15.193]:30988 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265816AbTA2M0Z>;
	Wed, 29 Jan 2003 07:26:25 -0500
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-dcl2
References: <1043794298.10153.241.camel@dell_ss3.pdx.osdl.net.suse.lists.linux.kernel> <1043798822.10150.318.camel@dell_ss3.pdx.osdl.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Jan 2003 13:35:46 +0100
In-Reply-To: Stephen Hemminger's message of "29 Jan 2003 01:12:53 +0100"
Message-ID: <p73el6wyvz1.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> writes:

> > . Lockless gettimeofday                 (Andi Kleen, me)

The original algorithm actually came from Andrea Arcangeli,
I just ported it from vsyscalls to do_gettimeofday.

> > . Performance monitoring counters for x86 (Mikael Pettersson)

Isn't that slightly redundant with oprofile?
They have different capabilities, but there is still much overlap.

-Andi

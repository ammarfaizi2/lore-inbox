Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWAYR0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWAYR0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWAYR0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:26:44 -0500
Received: from mail.shareable.org ([81.29.64.88]:31954 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S932080AbWAYR0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:26:43 -0500
Date: Wed, 25 Jan 2006 17:26:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: bernd@firmix.at, vonbrand@inf.utfsm.cl, linux-os@analogic.com,
       ram.gupta5@gmail.com, mloftis@wgops.com, barryn@pobox.com,
       a1426z@gawab.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060125172607.GA14864@mail.shareable.org>
References: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl> <1138181033.4800.4.camel@tara.firmix.at> <20060125150516.GB8490@mail.shareable.org> <20060125170904.5e31e1e2.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125170904.5e31e1e2.diegocg@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> Opera is probably the best browser when it comes to "features per byte
> of memory used"

Really?  If I'm making use it, maybe visiting a few hundred pages a
day, and opening 20 tabs, I find I have to kill it every few days, to
reclaim the memory it's hogging, when its resident size exceeds my RAM
size and it starts chugging.

> Also, fontconfig allocates ~100 KB of memory per program launched.
> There're patches to fix that by creating a mmap'able cache which is
> shared between all the applications which has been merged in the
> development version. I think there're many low-hanging fruits at
> all levels, the problem is not just mozilla & friends

100kB per program, even for 100 programs, is nothing compared a
browser's 300MB footprint.  Now, some of that 300MB is permanently
swapped out for the first few days of running.  Libraries and such.
Which is relevant to this thread: swap is useful, just so you can swap
out completely unused parts of programs.  (The parts which could be
optimised away in principle).

-- Jamie

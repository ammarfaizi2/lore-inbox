Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUB2C36 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 21:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUB2C36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 21:29:58 -0500
Received: from ns.suse.de ([195.135.220.2]:3786 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261967AbUB2C35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 21:29:57 -0500
Date: Sun, 29 Feb 2004 03:29:47 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040229032947.2f97ed79.ak@suse.de>
In-Reply-To: <20040229013923.GV8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random>
	<Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
	<20040227122936.4c1be1fd.akpm@osdl.org>
	<20040227211548.GI8834@dualathlon.random>
	<162060000.1077919387@flay>
	<20040228023236.GL8834@dualathlon.random>
	<20040228045713.GA388@ca-server1.us.oracle.com>
	<20040228061838.GO8834@dualathlon.random>
	<p73eksf4big.fsf@verdi.suse.de>
	<20040229013923.GV8834@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004 02:39:24 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

> you're wrong about s/vm_next/rb_next()/, walking the tree like in
> get_unmapped_area would require recurisve algos w/o vm_next, or
> significant heap allocations. that's the only thing vm_next is needed
> for (i.e. to walk the tree in order efficiently). only if we drop all
> tree walks than we can nuke vm_next.

Not sure what you mean here. rb_next() is not recursive.

-Andi

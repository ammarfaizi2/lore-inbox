Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTA1VqY>; Tue, 28 Jan 2003 16:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbTA1VqX>; Tue, 28 Jan 2003 16:46:23 -0500
Received: from ns.suse.de ([213.95.15.193]:51716 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261398AbTA1VqW>;
	Tue, 28 Jan 2003 16:46:22 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: {sys_,/dev/}epoll waiting timeout
References: <20030122080322.GB3466@bjl1.asuk.net.suse.lists.linux.kernel> <Pine.LNX.4.33L2.0301281139570.30636-100000@dragon.pdx.osdl.net.suse.lists.linux.kernel> <20030128213621.GA29036@bjl1.asuk.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Jan 2003 22:55:42 +0100
In-Reply-To: Jamie Lokier's message of "28 Jan 2003 22:42:45 +0100"
Message-ID: <p73hebtym5d.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:
> 
> Which suggests that all the architectures are fine with all these
> "int" returns, except IA64.

x86-64 needs long returns too.

I think I fixed all of them, if you noticed any missing please let me now.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263048AbTCLFp0>; Wed, 12 Mar 2003 00:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263050AbTCLFp0>; Wed, 12 Mar 2003 00:45:26 -0500
Received: from ns.suse.de ([213.95.15.193]:32516 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263048AbTCLFpZ>;
	Wed, 12 Mar 2003 00:45:25 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, shemminger@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernelorg
Subject: Re: [PATCH] (8/8) Kill brlock
References: <Pine.LNX.4.44.0303111644060.3002-100000@home.transmeta.com.suse.lists.linux.kernel> <1047436263.20968.5.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Mar 2003 06:56:09 +0100
In-Reply-To: Alan Cox's message of "12 Mar 2003 02:27:44 +0100"
Message-ID: <p73smtt3z7q.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> If Linus is scared ;) then throw them at me for -ac by all means. Anyone
> running -ac IDE test sets is brave enough to run rcu network code 8)

It's unlikely to cause problems, unless you start/stop tcpdump all day.

Protocol addition/deletion is really rare.

-Andi

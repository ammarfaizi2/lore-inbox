Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263064AbTCLGZX>; Wed, 12 Mar 2003 01:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263065AbTCLGZX>; Wed, 12 Mar 2003 01:25:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39659 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263064AbTCLGZX>;
	Wed, 12 Mar 2003 01:25:23 -0500
Date: Tue, 11 Mar 2003 22:35:49 -0800 (PST)
Message-Id: <20030311.223549.53161356.davem@redhat.com>
To: ak@suse.de
Cc: alan@lxorguk.ukuu.org.uk, shemminger@osdl.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernelorg
Subject: Re: [PATCH] (8/8) Kill brlock
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73smtt3z7q.fsf@amdsimf.suse.de>
References: <Pine.LNX.4.44.0303111644060.3002-100000@home.transmeta.com.suse.lists.linux.kernel>
	<1047436263.20968.5.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel>
	<p73smtt3z7q.fsf@amdsimf.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 12 Mar 2003 06:56:09 +0100

   Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
   
   > If Linus is scared ;) then throw them at me for -ac by all means. Anyone
   > running -ac IDE test sets is brave enough to run rcu network code 8)
   
   It's unlikely to cause problems, unless you start/stop tcpdump all day.
   
   Protocol addition/deletion is really rare.

True, and this is why people should wrap their brains around
the patch or stress these specific cases really hard.

Rusty's module stress testers might be useful here.

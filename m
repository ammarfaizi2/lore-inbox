Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281714AbRKULJV>; Wed, 21 Nov 2001 06:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281711AbRKULJL>; Wed, 21 Nov 2001 06:09:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36877 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281703AbRKULJA>; Wed, 21 Nov 2001 06:09:00 -0500
Subject: Re: Swap
To: helgehaf@idb.hist.no (Helge Hafting)
Date: Wed, 21 Nov 2001 11:17:00 +0000 (GMT)
Cc: nleroy@cs.wisc.edu (Nick LeRoy), linux-kernel@vger.kernel.org
In-Reply-To: <3BFB7F2E.D45CB95C@idb.hist.no> from "Helge Hafting" at Nov 21, 2001 11:17:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E166VNE-0004jp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is not a design bug - it is a design tradeoff.  A stateful
> server might work if you have years of uptime or at least
> no unplanned downtime.  But such implementations tend to force
> clients to remount if the server ever go down.  That may
> be really annoying if you're accessing lots of servers.

NFS is at best "imitation stateless". You can do good stateful servers that
recover across both client and server machine failure. You can do far better
with them than with NFS - its just a bit harder.

Alan

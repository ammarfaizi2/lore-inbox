Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSHLOnQ>; Mon, 12 Aug 2002 10:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSHLOnQ>; Mon, 12 Aug 2002 10:43:16 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:38639 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318062AbSHLOnO>; Mon, 12 Aug 2002 10:43:14 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3D57C1F4.1040303@mandrakesoft.com> 
References: <3D57C1F4.1040303@mandrakesoft.com>  <200208120018.g7C0IFN185157@saturn.cs.uml.edu> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Aug 2002 15:46:34 +0100
Message-ID: <7652.1029163594@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
> > > A copy-file syscall would be nice, too, but that's just laziness
> > > talking....
 
> > You have a laptop computer with a USB-connected Ethernet.
> > You mount a NetApp or similar box via the SMB/CIFS protocol.
> > You see a multi-gigabyte file. You make a copy... ouch!!!
> > For each gigabyte, you hog the network for an hour.

> /bin/cp has these problems regardless of whether or not it uses a
> copy-file syscall.

Nope. There was a reason he specified SMB/CIFS.

--
dwmw2



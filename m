Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137189AbRAHHXT>; Mon, 8 Jan 2001 02:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137137AbRAHHW7>; Mon, 8 Jan 2001 02:22:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11906 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136990AbRAHHWz>;
	Mon, 8 Jan 2001 02:22:55 -0500
Date: Sun, 7 Jan 2001 23:05:45 -0800
Message-Id: <200101080705.XAA10098@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: pwc@speakeasy.net
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101080048460.2261-100000@localhost> (message from
	Paul Cassella on Mon, 8 Jan 2001 01:16:27 -0600 (CST))
Subject: Re: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH:
 "No such process")
In-Reply-To: <Pine.LNX.4.21.0101080048460.2261-100000@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 8 Jan 2001 01:16:27 -0600 (CST)
   From: Paul Cassella <pwc@speakeasy.net>

   Would it be more helpful if I were to check something like

     socki_lookup(file->f_dentry->f_inode)->ops == tcp_prot

   instead?

No, helpful would be for you to present us with a test case program
and the network device configuration you are using.  Are you using
netfilter?  Are you using tunneling, these sorts of things.

Basically, the things we would need need to know to be able to
duplicate your precise setup here locally in hopes of triggering the
problem ourselves.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

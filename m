Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129295AbQKVKbc>; Wed, 22 Nov 2000 05:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQKVKbW>; Wed, 22 Nov 2000 05:31:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20369 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129295AbQKVKbP>;
	Wed, 22 Nov 2000 05:31:15 -0500
Date: Wed, 22 Nov 2000 01:46:00 -0800
Message-Id: <200011220946.BAA07355@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: willy.lkml@free.fr
CC: linux-kernel@vger.kernel.org
In-Reply-To: <974885943.3a1b9437847da@imp.free.fr> (message from Willy Tarreau
	on Wed, 22 Nov 2000 10:39:03 +0100 (MET))
Subject: Re: [BUG] 2.2.1[78] : RTNETLINK lock not properly locking ?
In-Reply-To: <974885943.3a1b9437847da@imp.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 22 Nov 2000 10:39:03 +0100 (MET)
   From: Willy Tarreau <willy.lkml@free.fr>

   Thanks in advance for any comment,

All of this is protected by lock_kernel() so none of the
A,B,C,whatever spots can be interrupted in 2.2.x

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

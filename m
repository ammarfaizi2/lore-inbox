Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVFOVYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVFOVYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVFOVYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:24:12 -0400
Received: from mail.dif.dk ([193.138.115.101]:33495 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261579AbVFOVYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:24:09 -0400
Date: Wed, 15 Jun 2005 23:29:32 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       James Morris <jmorris@redhat.com>, Ross Biro <ross.biro@gmail.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [-mm PATCH][0/4] net: signed vs unsigned cleanup in net/ipv4/raw.c
Message-ID: <Pine.LNX.4.62.0506152234040.3842@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

As promised, my previous net/ipv4/raw.c signed/unsigned cleanup patch in 
little bits with explanations.

This series of patches cleans up signed versus unsigned variable use in 
net/ipv4/raw.c .
The patches are created incrementally on top of each other but will 
probably each apply (with a little fuzz) on their own out of order.

Please keep me on CC if you reply since I'm not subscribed to both lists 
the patches are send to (only to lkml).


-- 
Jesper Juhl 



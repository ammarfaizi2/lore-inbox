Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129874AbQK2ERd>; Tue, 28 Nov 2000 23:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130322AbQK2ERY>; Tue, 28 Nov 2000 23:17:24 -0500
Received: from cebu.mozcom.com ([207.0.115.45]:13842 "EHLO cebu.mozcom.com")
        by vger.kernel.org with ESMTP id <S129874AbQK2ERL>;
        Tue, 28 Nov 2000 23:17:11 -0500
Date: Wed, 29 Nov 2000 11:47:08 +0800 (PHT)
From: Gerard Paul Java <gerardj@cebu.mozcom.com>
To: linux-kernel@vger.kernel.org
Subject: PF_PACKET and Token Ring
Message-ID: <Pine.LNX.4.03.10011291143490.10359-100000@cebu.mozcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying to capture IP packets over a Token Ring network through a
(PF_PACKET, SOCK_RAW) socket, but for some
reason the sll_protocol field in the sockaddr_ll structure doesn't
contain ETH_P_IP for IP packets but rather contains 0x100 (of course, in
network byte order).

Is this a bug, or is it expected behavior?

----------------------------------------------------------------
Gerard Paul R. Java
System Administrator, Mosaic Communications Cebu
primary: riker@mozcom.com
secondary: gerardj@cebu.mozcom.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263608AbRFARFA>; Fri, 1 Jun 2001 13:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263619AbRFAREu>; Fri, 1 Jun 2001 13:04:50 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:38408 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S263608AbRFAREi>; Fri, 1 Jun 2001 13:04:38 -0400
Date: Fri, 1 Jun 2001 19:04:32 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: [newbie] NFS client: port-unreachable
Message-ID: <Pine.LNX.4.31.0106011855520.13429-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

When I lstat64 a directory on an nfs mount the answer to GETATTR is
received by the network interface but dropped (not seen by the client)
afterwards. Only 50musec after the receive of the answer an
icmp-destination-unreachable (port-unreachable) goes out to the server.
This is annoying since it blocks all access to that directory.
The request in question is sent and received at port 772.

I'm using kernel 2.4.4.

Please help,
					Roland


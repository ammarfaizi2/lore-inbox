Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRBMXDw>; Tue, 13 Feb 2001 18:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbRBMXDm>; Tue, 13 Feb 2001 18:03:42 -0500
Received: from [207.199.12.19] ([207.199.12.19]:30988 "EHLO
	centrum.jedi-group.com") by vger.kernel.org with ESMTP
	id <S129115AbRBMXD3>; Tue, 13 Feb 2001 18:03:29 -0500
Date: Tue, 13 Feb 2001 15:03:23 -0800 (PST)
From: "Erik G. Burrows" <egb@erikburrows.com>
To: linux-kernel@vger.kernel.org
Subject: Multicast on loopback?
Message-ID: <Pine.LNX.4.21.0102131445030.11824-100000@centrum.jedi-group.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In developing multicast applications, I would like to be able to test
locally over the loopback interface. This does not work without adding a 
bogus route statement to get the kernel to hand up the packets from
loopback to my waiting application.

This route statement is not necessary with other network drivers, so I
assume that adding some logic to the loopback driver would fix this
problem. Is it possible to get this added?

-Erik G. Burrows


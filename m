Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSFZBsh>; Tue, 25 Jun 2002 21:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316243AbSFZBsg>; Tue, 25 Jun 2002 21:48:36 -0400
Received: from pophost.cs.tamu.edu ([128.194.130.106]:1197 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S316235AbSFZBsg>;
	Tue, 25 Jun 2002 21:48:36 -0400
Date: Tue, 25 Jun 2002 20:48:36 -0500 (CDT)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: linux-kernel@vger.kernel.org
Subject: packet trip vs scheduling
Message-ID: <Pine.SOL.4.10.10206252038340.1540-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guys,
	I have a trouble here and need to know a packet's trip (linux
kernel 2.4.18) from entering a NIC to arriving at the application in
application layer.

	The big problem is that I also need to know who may interrupt
the processing of this packet, i.e., which kernel or user processes may
preempt the processing of this packet when the packet is in NIC, device
driver, IP layer, transport layer, and applciation layer. That is, I want
to know the packet processing's priority in different layers.

	Hope you great guys can give me some hints!

	Thanks!

Xinwen Fu



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310228AbSBRIJO>; Mon, 18 Feb 2002 03:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310229AbSBRIJF>; Mon, 18 Feb 2002 03:09:05 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:17281 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S310228AbSBRII4>;
	Mon, 18 Feb 2002 03:08:56 -0500
Date: Mon, 18 Feb 2002 17:08:43 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
X-X-Sender: tomh@holly.crl.go.jp
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Unknown HZ value! (1908) Assume 1024.
Message-ID: <Pine.LNX.4.44.0202181705080.26361-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After about 50 days of uptime on 2.4.17 on an Alpha, I started getting
this message from ps, et al.  The adjtimex program says:

         mode: 0
       offset: -2942
    frequency: -11020216
etc. (I'm running ntpd).

50 days is about 4320000000 clock ticks (normally 1024 Hz) which is
suspiciously close to 2^32.  Perhaps something is rolling over?


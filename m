Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280415AbRKEJTC>; Mon, 5 Nov 2001 04:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280416AbRKEJSy>; Mon, 5 Nov 2001 04:18:54 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:11979 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S280415AbRKEJSp>;
	Mon, 5 Nov 2001 04:18:45 -0500
Date: Mon, 5 Nov 2001 18:18:38 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6 freeze mounting ext2 diskette
Message-ID: <Pine.LNX.4.30.0111051816020.675-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried swapping the floppy.c from 2.4.12, but it still fails.

lsmod floppy works (though the use count remains 0 and the ioports
aren't set up yet) then
	dd if=/dev/fd0 of=/dev/null bs=1024 count=1
turns the motor on and then the system freezes (motor stays on).


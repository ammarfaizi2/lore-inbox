Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSF2H3W>; Sat, 29 Jun 2002 03:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSF2H3V>; Sat, 29 Jun 2002 03:29:21 -0400
Received: from kuma.unm.edu ([129.24.9.36]:23238 "HELO kuma.unm.edu")
	by vger.kernel.org with SMTP id <S317192AbSF2H3U>;
	Sat, 29 Jun 2002 03:29:20 -0400
To: linux-kernel@vger.kernel.org
Subject: IO and PCI
Date: Sat, 29 Jun 2002 01:31:42 -0600
From: sheltraw@unm.edu
Message-ID: <1025335902.3d1d625ef2db3@webmail.unm.edu>
X-Mailer: UNM WebMail Cyrusoft Silkymail v1.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: 204.252.57.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kernel List

Is there a way to disable IO read/writes to a PCI device. The bit 0
of command register in PCI configuration space can be used to 
disable/enable memory-mapped IO but will it disable direct IO 
(what is the proper term?) as well?

I would like to be able to disable direct IO read/writes to one of
two video cards in an x386 while leaving the other alone. Then
I could use the direct IO registers to do palette changing and
enable interrupts on vertical blanking without doing so on both 
cards (since they both respond to the same direct IO addresses). 

Of course if I knew the addresses/offsets for memory-mapped versions
of the appropriate registers on one card I could solve this problem
but I do not neccesarily have that info.

Thanks for any help!
Daniel Sheltraw

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312317AbSDPK6x>; Tue, 16 Apr 2002 06:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312332AbSDPK6w>; Tue, 16 Apr 2002 06:58:52 -0400
Received: from [129.27.43.9] ([129.27.43.9]:60395 "EHLO xarch.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S312317AbSDPK6w>;
	Tue, 16 Apr 2002 06:58:52 -0400
Date: Tue, 16 Apr 2002 12:39:07 +0200 (CEST)
From: <mtopper@xarch.tu-graz.ac.at>
To: support@suse.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: USB-Mouse-Bug in 2.4.16-8 ?
In-Reply-To: <20020416102501.GG17043@suse.de>
Message-ID: <Pine.LNX.4.21.0204161234520.5014-100000@xarch.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Mailing List, 

I've discovered that even if I insmod (or modprobe) the proper USB modules
for my 2.4.16 kernel, and if I use the USB mouse afterwards,
"lsmod" reveals that the modules seem to be "(0) unused" - despite the USB
mouse is in action!

Users of the 2.4.18-kernel affirmed same kernel behaviour.

If I rmmod the USB modules, they subsequently allow to be removed from
kernelspace, and the USB mouse cursor , ofcourse , stops instantly -
despite he was just in use. 

Is this a bug or a feature? :-)

Yours, Alex



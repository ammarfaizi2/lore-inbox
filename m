Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272484AbRIKOoq>; Tue, 11 Sep 2001 10:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRIKOoh>; Tue, 11 Sep 2001 10:44:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36357 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266827AbRIKOoS>; Tue, 11 Sep 2001 10:44:18 -0400
Subject: Re: Resource starvation on a 2.2.19 web server
To: mbrennen@fni.com (Michael Brennen)
Date: Tue, 11 Sep 2001 15:48:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0109101920160.9125-100000@henry.fni.com> from "Michael Brennen" at Sep 10, 2001 08:01:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15goqQ-0002lq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> servers.  If I USR1 warm start apache, nslookup immediately works
> again.  Some system resource is being freed up when apache is
> restarted, but I've been unable to isolate what it is or fix it.

How old is your C library ? Im wondering if its old enough that some 
stuff only works for 256 file handles. That might explain DNS failing.

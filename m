Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262351AbRERPhX>; Fri, 18 May 2001 11:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262353AbRERPhN>; Fri, 18 May 2001 11:37:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11277 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262343AbRERPgx>; Fri, 18 May 2001 11:36:53 -0400
Subject: Re: FIC AD11(AMD 761/VIA 686B) AGP port not supported
To: jcorbin@linuxmail.org (Joshua Corbin)
Date: Fri, 18 May 2001 16:33:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010518142110.29102.qmail@linuxmail.org> from "Joshua Corbin" at May 18, 2001 10:21:09 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150mGE-0007Ec-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> agpgart: Maximum main memory to use for agp memory: 94M
> agpgart: Unsupported AMD chipset (device id: 700e), you might want to try agp_try_unsupported=1.
> agpgart: no supported devices found.
> 
> What does agp_try_unsupported mean?  Where do I set this setting?

It says 'assume this chipset is generically like the ones from that vendor I
already know about specifically'

	rmmod agpgart (if loaded)
	modprobe agpgart agp_try_unsupported=1

Be aware that it might crash the box of course

And report if it worked


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSKZXOx>; Tue, 26 Nov 2002 18:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSKZXOx>; Tue, 26 Nov 2002 18:14:53 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:12300 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262452AbSKZXOv>; Tue, 26 Nov 2002 18:14:51 -0500
Date: Tue, 26 Nov 2002 23:22:07 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrey Panin <pazke@orbita1.ru>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Fbdev 2.5.49 BK fixes.
In-Reply-To: <20021122100215.GA4998@pazke.ipt>
Message-ID: <Pine.LNX.4.44.0211262306070.30451-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hm. Strange. It should work. Can you get serial console working? 
> 
> Forgot to mention, I've seen message:
> 	fbcon_setup: No support for fontwidth 8
> in /var/log/dmesg. 
> 
> I found this printk() in fbcon_setup(), but i can't even imagine 
> why it happens.

Perfect. I found the problem and I'm about to commit to BK. I posted the 
latest patch against 2.5.49 at

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

> I understand this situation perfectly, looks like it's almost common for
> developers working in "not so importatnt for servers" subsystems :(

:-( Some day that attitude will change.

P.S

    Several drivers have been ported but not all. NVIDIA is still broken 
but I will fix it tonight.


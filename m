Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132941AbRAJUmH>; Wed, 10 Jan 2001 15:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132907AbRAJUl5>; Wed, 10 Jan 2001 15:41:57 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:3805
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S132216AbRAJUlm>; Wed, 10 Jan 2001 15:41:42 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDC78@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>,
        "'Linux Network List'" <linux-net@vger.kernel.org>
Subject: Porting network driver to 2.4.0
Date: Wed, 10 Jan 2001 15:40:50 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

Still working with kernel 2.4.0-test9 (other things we use require it for
now), and I was looking at a driver for a Znyx zx346q network card that I
grabbed from the znyx.com website.  The driver is for a 2.2.x kernel, but
figuring I'd try it anyway, downloaded and tried to build it.  It choked on
three struct net_device entries which are no longer present:
                                                  
zxe.c:1200: structure has no member named `tbusy'
zxe.c:1201: structure has no member named `interrupt'
zxe.c:1202: structure has no member named `start'
...
make[2]: *** [zxe.o] Error 1                              

Where do I go from here?  Is there info somewhere to help with this?  Is
this a bigger job than it looks on the surface?

Cheers!
Jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

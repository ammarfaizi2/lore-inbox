Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbRBGFVW>; Wed, 7 Feb 2001 00:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbRBGFVL>; Wed, 7 Feb 2001 00:21:11 -0500
Received: from [203.20.159.141] ([203.20.159.141]:25874 "EHLO memim01")
	by vger.kernel.org with ESMTP id <S129283AbRBGFUy>;
	Wed, 7 Feb 2001 00:20:54 -0500
Message-Id: <974A613A43EED311ACBD00508B5EF8C1D66DEF@meexc04.jbwere.com.au>
From: JShaw@jbwere.com.au
To: linux-kernel@vger.kernel.org
Subject: 2.4.x and oops on 'mount -t smbfs'
Date: Wed, 7 Feb 2001 17:19:45 +1100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I'm running RedHat 7.0 on a Compaq Proliant 5500, 4x Xeon 550MHz, 4GB 50Ns
EDO RAM.  Under kernel 2.2.16-22 I'm able to use

	'mount -t smbfs //ntserver/share /net -o
username=me,password=mine,workgroup=yours'

... without a problem.  NT files become available under '/net', as expected.
I've compiled a number of 2.4.1 and 2.4.0 kernels (actually supports the 4GB
RAM!!!  Yay!!!!), and I have only one more problem to sort out.  Under
2.4.x, the mount completes successfully, but 'ls /net' causes an OOPS: 0000.

I've compiled Samba support into the kernel, and the version of Samba utils
is 2.0.7-21ssl

Any clues or similar experiences???

Thanx,

Jim Shaw.
		      JBWere Limited
			DISCLAIMER

JBWere Limited and its related entities distributing this document and 
each of their respective directors, officers and agents ("the Were Group") 
believe that the information contained in this document is correct and that
any estimates, opinions, conclusions or recommendations contained in this 
document are reasonably held or made as at the time of compilation. However, 
no warranty is made as to the accuracy or reliability of any estimates, 
opinions, conclusions, recommendations (which may change without notice) or 
other information contained in this document and, to the maximum extent 
permitted by law, the Were Group disclaims all liability and responsibility 
for any direct or indirect loss or damage which may be suffered by any recipient 
through relying on anything contained in or omitted from this document.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

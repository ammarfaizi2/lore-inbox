Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbQKCSgd>; Fri, 3 Nov 2000 13:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbQKCSgY>; Fri, 3 Nov 2000 13:36:24 -0500
Received: from pD4B9E998.dip.t-dialin.net ([212.185.233.152]:60938 "HELO
	zeno.dyndns.org") by vger.kernel.org with SMTP id <S129953AbQKCSgQ>;
	Fri, 3 Nov 2000 13:36:16 -0500
Date: Fri, 3 Nov 2000 19:36:29 +0100
To: linux-kernel@vger.kernel.org
Subject: loop device hangs
Message-ID: <20001103193629.A2178@warande1125.warande.uu.nl>
Reply-To: C.J.vanEnckevort@gmx.net
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org>; from tytso@mit.edu on Fri, Nov 03, 2000 at 10:09:31AM -0500
From: chris@warande1125.warande.uu.nl (Christian van Enckevort)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 10. To Do But Non Showstopper
> 
>      * Loop device can still hang (William Stearns has script that will
>        hang 2.4.0-test7, Peter Enderborg has a short sequence that will
>        hang 2.4.0test9)
I think I have the same problem with 2.4.0-test10 (with rieserfs-patch). 
With small images (initrd-ramdisk) I have no problem, but when I prepare an
ext2fs-image for a backup on CD, the system will invariably hang. For me
this is a showstopper bug. I tried to further investigate this bug. I found
it can also be triggered by running bonnie on an ext2fs-image
(filesize=200Mb). When it hung, the EIP pointed to somewhere in
default_idle. Does anybody have some hints for finding some more useful
information about this bug?

Christian van Enckevort
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130676AbQLQUM3>; Sun, 17 Dec 2000 15:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbQLQUMU>; Sun, 17 Dec 2000 15:12:20 -0500
Received: from tahallah.claranet.co.uk ([212.126.138.206]:1028 "EHLO
	tahallah.clara.co.uk") by vger.kernel.org with ESMTP
	id <S130676AbQLQUML>; Sun, 17 Dec 2000 15:12:11 -0500
Date: Sun, 17 Dec 2000 19:41:03 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.clara.co.uk>
Reply-To: <alex.buell@tahallah.clara.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.18 ide-scsi & scsi generic modules
Message-ID: <Pine.LNX.4.30.0012171937290.275-100000@tahallah.clara.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a post on linux-kernel earlier today stating that "hdx=scsi" did
not work correctly if both were compiled as modules for 2.4.10-testxx and
a patch was posted.

I can confirm that this is true for 2.2.x, with "hdx=ide-scsi". Once I
compiled both statically into the kernel, it works.

Perhaps somone can backport the fixes? It would be nice to change 2.2 so
it can accept "hdx=scsi" for compatiblity with 2.4.

Cheers,
Alex
-- 
The truth is out there.

http://www.tahallah.clara.co.uk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

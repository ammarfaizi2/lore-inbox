Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276057AbRJBRkh>; Tue, 2 Oct 2001 13:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276058AbRJBRk1>; Tue, 2 Oct 2001 13:40:27 -0400
Received: from mailgw.netvision.net.il ([194.90.1.9]:1997 "EHLO
	mailgw2.netvision.net.il") by vger.kernel.org with ESMTP
	id <S276057AbRJBRkL>; Tue, 2 Oct 2001 13:40:11 -0400
Date: Tue, 2 Oct 2001 19:41:53 +0200 (IST)
From: Lior Okman <lior@netvision.net.il>
To: linux-kernel@vger.kernel.org
Subject: Strange CD-writing problem
Message-ID: <Pine.LNX.4.21.0110021939550.1608-100000@goblin.realms>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,
 
I recently bought a new IDE cd-rw (a Plextor W1610A).
While trying to burn with it, I had some trouble fixating the disks.
The burn process would work fine, but when the fixating started, the
ide-scsi emulation started resetting the IDE bus, or just timing out.
This is true for every 2.4 kernel, from 2.4.0 to 2.4.10 including selected
ac versions.
 
The cd writer is connected to the computer as a primary device of the
third IDE bus (an onboard Promise chip), which kernels 2.2 don't support
out-of-the-box. I patched the 2.2.19 kernel to add support for Promise
cards, added reiserfs, and tried burning with this kernel, and it worked
flawlessly. The cdrecord versions I used were version 1.11a07, and also
version 1.10a18.

I'd appreciate help in making the cd-writer usable with a 2.4 kernel.

Thanks 
Lior Okman


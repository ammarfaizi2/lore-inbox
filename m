Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRAXPiN>; Wed, 24 Jan 2001 10:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132130AbRAXPiA>; Wed, 24 Jan 2001 10:38:00 -0500
Received: from post.it.helsinki.fi ([128.214.205.24]:49929 "EHLO
	post.it.helsinki.fi") by vger.kernel.org with ESMTP
	id <S129830AbRAXPhv>; Wed, 24 Jan 2001 10:37:51 -0500
Date: Wed, 24 Jan 2001 17:45:58 +0200
From: Robert Holmberg <robert.holmberg@helsinki.fi>
To: linux-kernel@vger.kernel.org
Subject: nividia fb 0.9.0?
Message-ID: <20010124174558.A6608@chefren>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw version 0.9.0 of the nvidia fb driver floating around on the nvidia
for linux mailing list some time ago. I tried it and liked it, it was A LOT
faster and seemingly bug-free. I decided to wait for it to get integrated
into the kernel. Time has gone by, the linux-nvidia archives are down and
no-one seems to have submitted this patch, despite the fact that there was
some talk about who should do it on the linux-nvidia-list. Has anyone tried
to submit this? Otherwise I have it right here, not in patch format, but as
a tar file including all files in the riva directory. 

fbdev.c lists changes by Jindrich Makovicka:  accel code help, hw cursor,
mtrr support.

There was a minor bugfix patch to this one as well, I think it's applied to
my version since the version number is 0.9.0jm2, but I can't recall for
sure. 

I don't know if I could make a correct patch, since one filename
seems to have changed from nv_local.h to nv4ref.h, and the official 
kernel version has some changes made after ths version was released 
(in November I think).

I'm putting the file up here in case someone wants to make a patch out of 
it and submit it to Linus:

http://www.helsinki.fi/~rahholmb/rivafb-0.9.0jm2.tar.gz (35Kb)

Please cc to me, I'm not on the list.

Robert.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

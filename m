Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130613AbRAaTIE>; Wed, 31 Jan 2001 14:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130936AbRAaTHp>; Wed, 31 Jan 2001 14:07:45 -0500
Received: from versus.dmz.advance.net ([208.217.108.49]:27403 "EHLO
	versus.dmz.advance.net") by vger.kernel.org with ESMTP
	id <S130613AbRAaTHo>; Wed, 31 Jan 2001 14:07:44 -0500
Date: Wed, 31 Jan 2001 14:07:43 -0500
From: Joe Lizzi <jlizzi@versus.dmz.advance.net>
Message-Id: <200101311907.OAA05707@versus.dmz.advance.net>
To: linux-kernel@vger.kernel.org
Subject: e820 Memory Detect Backport Patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to extract *just* the E820 memory detect patch from the
2.2.19-pre1 patch? We recently received a bunch of new Intel server
boxes with the STL2 motherboard. However, 2.2.1x refuses to detect more
than 64Megs of RAM; I've heard that this patch fixes that problem. (A
different solution is to upgrade the BIOS to 1.4 (Build 18), but although
the updated Intel docs mention this BIOS revision, it isn't available on
the Intel site.)

Theorectically, I could extract the patched files myself from the breakdown
of the pre-2.2.19-1 patch on linuxhq.com. My main fear would be either
missing something, or including a change relating to something else in the
patch set that subsquently breaks things. And since these boxes have to go
into production relatively quickly, I'd rather not install the complete
pre-2.2.19-7 patch set, if I can avoid it. (The higher ups frown heavily
on anything that doesn't appear to be "production ready".)

I would appreciate any help, either via a list of file patches that I can
extract, or through some pointer to a place where I can download just this
patch.

Thanks.

===================================================
Joe Lizzi                                SysAdmin
jlizzi@advance.net                Advance Internet   
201-459-2826
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

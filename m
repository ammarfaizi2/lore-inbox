Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbQLXPxv>; Sun, 24 Dec 2000 10:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131154AbQLXPxm>; Sun, 24 Dec 2000 10:53:42 -0500
Received: from ip165-74.fli-ykh.psinet.ne.jp ([210.129.165.74]:15556 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S129749AbQLXPxb>;
	Sun, 24 Dec 2000 10:53:31 -0500
Message-ID: <3A4614D6.85251E69@yk.rim.or.jp>
Date: Mon, 25 Dec 2000 00:23:02 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Guest section DW <dwguest@win.tue.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE woes:linux and BIOS won't agree on C/H/S detection
In-Reply-To: <3A424B0F.39E71E4F@yk.rim.or.jp> <20001221222735.A15396@win.tue.nl> <3A436F2D.3F15E158@yk.rim.or.jp> <20001222163447.A16476@win.tue.nl>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent out a longish response a few minutes ago which explained
the my problem was solved somehow!

One thing I missed explaining in my original post is
the AMI BIOS on the GA-7IXE4 motherboard
has a very spartan set of options.

For the geometry translation of ATA disk, only
On/Off choice was available and according to help message
On means LBA and Off is non-LBA (normail?).
I let LBA on during my trials and errors.

AWARD BIOS would have shown
none/auto/large/lba, etc. for the same choice.

Well, AMI BIOS seems to be pretty minor these days. I have seen it
lately
on my current motherboard as well as onthe low-price end machines from
small vendors,  inside VMware's virtual PC environment(!), but
nowhere else. There could be some rough edges still around due to
smaller
user base.

I am glad I have been using SCSI disk.
If it had not been for my 2.4.0-test12 on a scsi disk I moved from my
old PC,
I would not have been able to
use linux successfully with Win98 partition on
this motherboard for a couple of weeks.

I guess my motherboard is somewhat exceptional case where BIOSreports a
geometry
that didn't match the geometry used by popular OSes.

Again thank you everybody for helpful tips.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

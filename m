Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTE2HEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 03:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTE2HEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 03:04:39 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:13780 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP id S261959AbTE2HE1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 03:04:27 -0400
From: Pasi Savilaakso <pasi.savilaakso@pp.inet.fi>
Organization: Linsystems
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page...
Date: Thu, 29 May 2003 10:19:30 +0300
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305291019.34305.pasi.savilaakso@pp.inet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi, all

I am not really sure if this is the same problem which I suffer from. But at 
least it sounds like it is.

In my case I get total system freeze up every time I copy something from fs to 
another and I have xawtv running. system is freezed up totally, no mouse 
movement, no response to keyboard, hd activity light is lit and constantly 
burning but nothing happens. First I thought that it could be a fs problem 
but I have tested all kinds of combinations. 

ext2->ext2
ext2->ext3
ext3->ext3
ext3->reiserfs
reiserfs ->reiserfs
xfs->xfs 
etc. 

everytime with same results, hds are changed, mb is changed, nothing helps. I 
cannot actually go back in kernel since 2.4.21-pre3 was first kernel which 
works with my new motherboard. I dont remember when this started to happen. I 
also suspected that It might be somekind pause problem so I left my system to 
finish its copy process. but after 2 days I resetted computer an no files 
were moved. Some progress has happened since now sound from bttv comes out 
even system is freezed. some times ago the sound was freezed too. 

lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 02)
00:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
02)
00:07.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NE [Radeon 
9700]
01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 9700] 
(Secondary)

everything else but ethernet controller and bt878 has changed. 

I get random freezes if I read or write to one fs and I use my bt878. 

This has been problem quite long time now and I first suspected something else 
than kernel long time but I ruled them out one by one. Currently running with 
2.4.21-rc6. 


Pasi Savilaakso
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+1bSGCATNOy4O2C4RAnMWAKCDymJBC/+hiJy6BAfChv/HB3EI0wCfecrW
iIQGtx028avmhGelBe/CUis=
=kmyd
-----END PGP SIGNATURE-----



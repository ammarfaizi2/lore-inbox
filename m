Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274666AbRJEXpu>; Fri, 5 Oct 2001 19:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRJEXpl>; Fri, 5 Oct 2001 19:45:41 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:49537 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S274669AbRJEXpb>; Fri, 5 Oct 2001 19:45:31 -0400
Date: Sat, 6 Oct 2001 09:45:58 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: sym53c1010 issues
Message-ID: <20011006094558.B440@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am currently getting the following errors in dmesg:

sym53c1010-33-0:0: ERROR (81:0) (8-0-0) (3e/18) @ (mem 6d40383c:ffffffff).
sym53c1010-33-0: regdump: da 00 00 18 47 3e 00 0f 04 08 80 00 00 00 0f 0a 28 96 
7e 12 02 00 00 00.
sym53c1010-33-0: ctest4/sist original 0x8/0x0  mod: 0x18/0x0
sym53c1010-33-0: restart (scsi reset).
sym53c1010-33-0: handling phase mismatch from SCRIPTS.
sym53c1010-33-0: Downloading SCSI SCRIPTS.
sym53c1010-33-0-<0,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
sym53c1010-33-0:0: ERROR (81:0) (8-0-0) (3e/18) @ (script 50:f31c0004).
sym53c1010-33-0: script cmd = 90080000
sym53c1010-33-0: regdump: da 00 00 18 47 3e 00 0f 00 08 80 00 00 00 0f 0a 0a 4d 
5f 49 02 00 00 00.
sym53c1010-33-0: ctest4/sist original 0x8/0x0  mod: 0x18/0x0
sym53c1010-33-0: restart (scsi reset).
sym53c1010-33-0: handling phase mismatch from SCRIPTS.
sym53c1010-33-0: Downloading SCSI SCRIPTS.
sym53c1010-33-0-<0,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)

and, after about 24hrs, the box seizes upon me requireing a reboot. The
kernel I'm using is 2.2.19 with raid0.9 and the latest sym* drivers (ie
not the ones that come with the kernel).

The main thing here is that I'm not sure if this is a h/w or s/w issue. Would
msgs like the above be due to the driver, the onboard scsi card or the HD?

Or am I asking the wrong questions? :)

There are other errors usually reported also and they deal with the 1st
SCA drive (with 1 or 2 of the 3rd drive). There are currently 3 SCA drives
on the first controller and 4 LVD drives (external array) on the 2nd. No
hotswapping is being done and there have been no errors reported re the
4 LVD drives as far as I know.

Anyone able to help?

-- 
CaT        "As you can expect it's really affecting my sex life. I can't help
           it. Each time my wife initiates sex, these ejaculating hippos keep
           floating through my mind."
                - Mohd. Binatang bin Goncang, Singapore Zoological Gardens

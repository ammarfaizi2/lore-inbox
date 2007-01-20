Return-Path: <linux-kernel-owner+w=401wt.eu-S965236AbXATKOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbXATKOT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 05:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbXATKOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 05:14:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:24685 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965236AbXATKOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 05:14:18 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GMNv3QeTpzm5mo1CIqxVte047weGwbXx+fIU89zVwe5TvBJ+mHwpAUM+mVSJh1cD7DyR0/LLct4ZSe8Kc3Hpc6DA1lOhUypxRJ3TU8Mh27tV0zPcR26Cuxeddk1O8hCcZHSADes9hBPOz4PVLHVDxsELqNMvH2IaThiarcq/mFo=
Message-ID: <8355959a0701200214r7dd68d4br97a8cbe091dfaaab@mail.gmail.com>
Date: Sat, 20 Jan 2007 15:44:16 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: More about dmesg stuff, this time 2.6.20-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I did find this dmesg for the kernel 2.6.20-rc5

Linux version 2.6.20-rc5-Typhoon (root@Typhoon) (gcc version 4.1.1
20061011 (Red Hat 4.1.1-30)) #1 SMP Sat Jan 20 15:00:20 IST 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end:
000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end:
00000000000a0000 type: 2
copy_e820_map() start: 00000000000e6000 size: 000000000001a000 end:
0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001f62f800 end:
000000001f72f800 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001f72f800 size: 0000000000000800 end:
000000001f730000 type: 4
copy_e820_map() start: 000000001f730000 size: 0000000000010000 end:
000000001f740000 type: 3
copy_e820_map() start: 000000001f740000 size: 00000000000b0000 end:
000000001f7f0000 type: 4
copy_e820_map() start: 000000001f7f0000 size: 0000000000010000 end:
000000001f800000 type: 2
copy_e820_map() start: 00000000e0000000 size: 0000000010000000 end:
00000000f0000000 type: 2
copy_e820_map() start: 00000000fed13000 size: 0000000000007000 end:
00000000fed1a000 type: 2
copy_e820_map() start: 00000000fed1c000 size: 0000000000084000 end:
00000000feda0000 type: 2

What are these sanitize start, sanitize end, copy_e820_map() about?
Memory check?


After this, dmesg is almost same as in 2.6.19.2. But here is another
observation::

migration_cost=18  for 2.6.19.2
migration_cost=87 for 2.6.20-rc5

How does this parameter value impacts the kernel?


Lastly, this about Intel RNG:

For 2.6.19.2

intel_rng: FWH not detected


For 2.6.20-rc5

intel_rng: Firmware space is locked read-only. If you can't or
intel_rng: don't want to disable this in firmware setup, and if
intel_rng: you are certain that your system has a functional
intel_rng: RNG, try using the 'no_fwh_detect' option.

Is this a bug? Or, something wrong with my H/W?


~Akula2

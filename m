Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262518AbREUW12>; Mon, 21 May 2001 18:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262520AbREUW1S>; Mon, 21 May 2001 18:27:18 -0400
Received: from [216.247.238.190] ([216.247.238.190]:24325 "HELO
	bisma.solotech.com") by vger.kernel.org with SMTP
	id <S262518AbREUW1J>; Mon, 21 May 2001 18:27:09 -0400
From: tryggveh@pakistanmail.com
Reply-to: tryggveh@pakistanmail.com
To: linux-kernel@vger.kernel.org
Date: Mon, 21 May 2001 18:28:28 -0400
Subject: 2.4.4-ac11 initrd image load from floppy hang keyboard
Message-id: <3b09404b.48f1.0@pakistanmail.com>
X-User-Info: 212.33.131.67
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I tried 2.4.4-ac11, plain kernel for booting custom installer, and loading an

initrd image from a secondary floppydisk, using syslinux 1.62 to boot the kernel.


These parameters were used:
ramdisk_start=0 load_ramdisk=1 prompt_ramdisk=1 ramdisk_size=12288 root=/dev/fd/0


This resulted in hanged keyboard, no response. But screenblanking obviously

worked as the screen blacked out after some time.

But the keyboard no response, not even Ctrl + Alt + Del worked.

The same kernel configuration on vanilla 2.4.4 worked fine.

So... something is terribly wrong here.

--
Tryggve
_______________________________________________________________________
Get your free @pakistanmail.com email address   http://pakistanmail.com

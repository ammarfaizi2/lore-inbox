Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSD0NNM>; Sat, 27 Apr 2002 09:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313818AbSD0NNL>; Sat, 27 Apr 2002 09:13:11 -0400
Received: from smtp1.wanadoo.nl ([194.134.35.136]:8330 "EHLO smtp1.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S313743AbSD0NNK>;
	Sat, 27 Apr 2002 09:13:10 -0400
Message-Id: <200204271313.g3RDD4024060@smtp1.wanadoo.nl>
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Dave Jones <davej@suse.de>
Subject: Re: Linux 2.5.10-dj1
Date: Sat, 27 Apr 2002 14:51:21 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020427030823.GA21608@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 April 2002 05:08, Dave Jones wrote:
> Clear out the pending patch queue, and merge up to Linus' latest
> in order to have a base to continue pushing bits from.
>

compiled fine, but after booting the system does not respond to the keyboard 
(I can see the message "serio: i8042 KBD port at 0x60,0x64 irq 1" om my 
screen)

The system also hangs after fscking my root partition (fsck completed without 
errors)
After my harddisks went to sleep I switched the system off and after booting 
the kernel (2.4.19-pre7) panics (and the caps- and scroll-lock leds are 
blinking) as it can not mount the root fs due to the following errors:
EXT2-fs error (device ide0(3,1)): ext2_check_descriptors: Block bitmap for 
group 0 not in group (block 0)!
EXT2-fs: group descriptors corrupted!

if it is needed i can send my .config after i have recovered my rootdisk.

	Rudmer

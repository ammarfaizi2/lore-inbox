Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRHWR3l>; Thu, 23 Aug 2001 13:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269067AbRHWR3b>; Thu, 23 Aug 2001 13:29:31 -0400
Received: from users.havenet.com ([209.208.35.2]:9734 "EHLO mail.havenet.com")
	by vger.kernel.org with ESMTP id <S268926AbRHWR3T>;
	Thu, 23 Aug 2001 13:29:19 -0400
Message-ID: <3B853C2A.1D60F860@aet-usa.com>
Date: Thu, 23 Aug 2001 13:23:54 -0400
From: Christopher Curtis <ccurtis@aet-usa.com>
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en-US,en,es
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: CMD649 RAID?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an IWILL KK-266R motherboard with an AMI HG80649 ATA100 IDE RAID
controller that shows up as a CMD649 with lspci.  I've set up a RAID1
array through the BIOS utility but Linux (2.4.[4-9]) can't seem to do
anything with it ...

hde and hdg are detected, but the IRQ probe fails so ide2 and ide3 are
disabled.  I can't access the machine right now, else I'd send some
logfiles.  I'm also running devfs and am a little lost, so I'm not sure
if it is simply unsupported or if I'm missing something.

With the motherboard comes a bootdisk that I can use to install RedHat
with a 2.2 kernel, but from what I read, after I install it, I can't do
anything else with the array.  There are some patches, but they seem to
already be integrated into 2.4.x>7 (the ide-patches no longer apply & I
get a lot of reversed patch messages).

2.4.9 only seems to have 'generic' CMD649 support, no raid, and I can't
find an entry in /proc or /dev relating to raid support.  Am I doing
something wrong, or am I screwed with 80GB inaccessible disk space?

Thanks in advance,
Christopher


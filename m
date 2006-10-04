Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWJDUdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWJDUdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWJDUdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:33:43 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:41114 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751087AbWJDUdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:33:42 -0400
Message-ID: <45241AA2.8020702@tlinx.org>
Date: Wed, 04 Oct 2006 13:33:38 -0700
From: "Linda W." <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Frank Sorenson <frank@tuxrocks.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Keyboard Stuttering (OS independant?)
References: <4523FA41.90805@tuxrocks.com>
In-Reply-To: <4523FA41.90805@tuxrocks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Sorenson wrote:
> I'm experiencing some severe keyboard stuttering on my laptop.  The 
> problem is particularly bad in X, and I believe it also occurs at the 
> console, though I'm having a difficult time verifying that.  The 
> problem  shows up as repeated characters (not regular 
> key-repeat-related), and sometimes dropped key presses.
>
> I'm running the 2.6.18 x86_64 kernel on a Core 2 Duo.
---
    Just a "datapoint", I noticed similar symptoms on a new Core-Duo
laptop running WinXP-SP2.  It appeared to drop "scancodes". 
Sometimes dropped the activation, down-stroke, sometimes dropped the
release-scan-code.  Was so bad it was bothering my wrists on the
laptop -- this was using an external, PS/2 keyboard.  Mouse also lost
appeared to lose interrupts, but results were not so noticeable.

    Finally returned laptop (Dell M90) because I couldn't spend
time debugging it as I was debugging other problems on a desk-side
Core-2 Duo.  I have noticed a similar problem on the Core-2 Deskside
(Dell 690) (running XP2) BUT with far less frequency.  Yet I still
notice it -- they keys seem to more likely lose a scan-code action
when I'm pressing multiple key combinations.  Result will be some
key acts like it is being held down.  Simply repressing the affected
key will stop the repeat, i.e. it seems to catch the release
scan-code if I press they key a 2nd time.  It's almost unnoticeable
on the desk-side Core-2 Duo (is at least rare enough to not be
able to reliably repeat), BUT on "Core-Duo" laptop (not core-2 duo),
it was very bad.

    Having just been "forced" into upgrading to SP2 (it came with the
new machine, SP1 won't install -- blue-screens, linux doesn't even
detect SAS-5 Hard Drive), I didn't know whether it was a hardware
or software problem).  Sorry don't have more linux stats now, but
have been trying to get out from under SP2 bugs (greatly incompatible
with my old SP1-compat apps), and my linux version(s) don't seem to like
the newer hardware.

    Anyone know much about differences in Serial-Attached-SCSI (SAS)
vs. SCSI?  I've heard that one of the Serial -HD controllers can handle
disks of the other type (SAS handling SATA or SATA handling SAS; likely
former, but source of comment was "theoretical", not in practice...).

    Anyway -- wanted to chime in on your keyboard symptom -- some of
the legacy keyboard/mouse stuff on some of the newer Core-Duo compat
motherboards /may/ be cross-OS flakey...  could be relevant datapoint.

    Good luck in chasing...

-l



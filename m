Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTFUUJN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 16:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbTFUUJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 16:09:13 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:40084 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S264190AbTFUUJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 16:09:12 -0400
Date: Sun, 22 Jun 2003 00:21:16 +0400
Message-Id: <200306212021.h5LKLGdv004822@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: severe FS corruption w/ reiserfs and 2.5.72-bk3
To: linux-kernel@vger.kernel.org, nettings@folkwang-hochschule.de
References: <3EF4C0CC.6090100@folkwang-hochschule.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joern Nettingsmeier <nettings@folkwang-hochschule.de> wrote:

JN> i just completely and utterly trashed my filesystems with 2.5.72-bk2 and 
JN> reiserfs. there are metric shitloads of errors on journal replay and i 
JN> end up in repair mode. did a couple of --rebuild-tree's, but new errors 
JN> cropped up after every reboot.
JN> happens both on scsi and ide drives and ate almost all of my machine...

Hm. Can I ask for your kernel config, and kernel logs (if possible),
reiserfsck /dev/device -l /somewhere/device.log , and send those logs to
me too.

JN> unfortunately i did a number of things at once: upgrade the kernel from 
JN> .72 (which has worked for me quite well), add an ide drive (i didn't 
JN> have ide in my kernel before, and geez! is that module code broken :)) 
JN> and shuffle partitions around. which makes the problem hard to pinpoint.

Not sure what bk3 is for, I have yesterday's bk snapshot and it works for me,
I seem to be unable to reach bkbits.net for today.

JN> if anyone wants me to do some forensics on the machine, speak up. 
JN> otherwise i'll swipe it clean and start over from scratch.

I wonder if you can create clean fs, copy some stuff there with 2.5.72-mm2
and see what happens?

Bye,
    Oleg

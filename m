Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUEPTPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUEPTPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 15:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbUEPTPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 15:15:16 -0400
Received: from eri.interia.pl ([217.74.65.138]:57456 "EHLO eri.interia.pl")
	by vger.kernel.org with ESMTP id S264791AbUEPTPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 15:15:12 -0400
Message-ID: <40A7BDBC.9010209@interia.pl>
Date: Sun, 16 May 2004 21:15:08 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040229)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: root fs on usb - is patching kernel still needed?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been trying to boot Linux from an root fs which is on an usb-stick 
(kernel is on a bootdisk floppy).

Unfortunately, the kernel seems to try to mount the filesystem which is 
on an usb-stick too fast, before usb shows up for the kernel.

While reading this list I found several patches solving this problem, 
which wait a bit before root fs is mounted, which re-try in a loop to 
mount root fs etc.


Are there any solutions for this problem in stable or pre- kernel tree 
yet (2.4 or 2.6)? If not, will such a solution be ever included in a 
stable kernel?

Or maybe are there any easier solutions for this (some lilo or grub option?)


Regards,

Tomasz Chmielewski



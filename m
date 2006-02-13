Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWBMEyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWBMEyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 23:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWBMEyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 23:54:15 -0500
Received: from terminus.zytor.com ([192.83.249.54]:169 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751615AbWBMEyO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 23:54:14 -0500
Message-ID: <43F010F3.5030305@zytor.com>
Date: Sun, 12 Feb 2006 20:54:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: klibc list <klibc@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: klibc tree status
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just pushed out a git tree which actually has the root-mounting 
code removed from the kernel.  Since there are any number of strange 
boot configurations out there, I would really appreciate any help in 
testing this stuff out.

I have *NOT* implemented support for the following, which I'm hoping has 
fallen out of use by now:

	-> Setting boot flags via rdev, as opposed to on the command
  	   line
	-> When loading the ramdisk from a block device, stop and
	   ask the user for a second disk.  This one could probably
	   be implemented without too much trouble if people actually
  	   care.

git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

	-hpa

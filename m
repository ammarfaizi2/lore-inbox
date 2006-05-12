Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWELS34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWELS34 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 14:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWELS34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 14:29:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:48254 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751220AbWELS34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 14:29:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mo7BgHtaDuf4X5r0IWkIv40bQKi2nqIiIUso9Ct4yrtj6JcvhRCDZLLYWhb7pEERZ8ipwaRVahllSdxaVMkQGwgAKwJRKLH1aUAehEXGHK7MqvRH2tsYzJmQIHkVoR6gdCydPc5SybN5e7thHVnwMsYFctSK2ssdxopTt6y/ZQU=
Message-ID: <3d78499d0605121129m3fe0951fy68e55ec1dce13397@mail.gmail.com>
Date: Fri, 12 May 2006 13:29:52 -0500
From: "Captain Wiggum" <captwiggum@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux kernel 2.6.16.14 boot errors: udevd-event: udev_make_node and find_free_number
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My 2.6.15.4 booted without any errors or warnings. Now with 2.6.16.14 I
get the below errors. I have also installed 2.6.16.14 on another
computer, and it works great there. I stepped through every kernel
config option and everything is in place.

Any ideas? All suggestions appreciated.

Gentoo, gcc 3.4.4-r1, P4-1.5GHz, 512MB RAM, hp pavilion 7955.

-------------------------
BOOT, CONSOLE MESSAGES:

...<snip>...
* Populating /dev with saved device nodes ...                            [ ok ]
* Seeding /dev with needed nodes ...
cp: cannot create special file `/dev/null': File exists
cp: cannot create special file `/dev/zero': File exists                  [ ok ]
* Setting up proper hotplug agent ...
*   Using netlink for hotplug events...                                  [ ok ]
* Starting udevd ...                                                     [ ok ]
* Populating /dev with existing devices through uevents ...
udevd-event[1462]: udev_make_node: mknod(/dev/ttyS0, 020660, 4, 64)
failed: File exists
udevd-event[1463]: udev_make_node: mknod(/dev/ttyS1, 020660, 4, 65)
failed: File exists
udevd-event[1464]: udev_make_node: mknod(/dev/ttyS2, 020660, 4, 66)
failed: File exists
udevd-event[1465]: udev_make_node: mknod(/dev/ttyS3, 020660, 4, 67)
failed: File exists
                                                                         [ ok ]
* Letting udev process events ...
udevd-event[1984]: find_free_number: %e is deprecated, will be removed
and is unlikey to work correctly. Don't use it.
udevd-event[1986]: find_free_number: %e is deprecated, will be removed
and is unlikey to work correctly. Don't use it.
                     [ ok ]
* Finializing udev configuration ...                                     [ ok ]
...<snip>...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWIKW73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWIKW73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWIKW73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:59:29 -0400
Received: from smtp.ono.com ([62.42.230.12]:36451 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932308AbWIKW72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:59:28 -0400
Date: Tue, 12 Sep 2006 00:59:27 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: libata sr0 not automounted
Message-ID: <20060912005927.73f9a19c@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.4.0cvs172 (GTK+ 2.10.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

My 2 ATA cd-roms, drived with libata, are not auto-mounted in gnome.
How can I debug this ?
Can I se if the kernel sends the correct events ?

udevmonitor says this when a zip disk is inserted and ejected:

werewolf:/home/magallon# udevmonitor
udevmonitor prints the received event from the kernel [UEVENT]
and the event which udev sends out after rule processing [UDEV]

UEVENT[1158015418.725812] add@/block/sda/sda1
UDEV  [1158015419.262449] add@/block/sda/sda1
UEVENT[1158015420.057831] mount@/block/sda/sda1
UDEV  [1158015420.058905] mount@/block/sda/sda1
UEVENT[1158015428.923382] umount@/block/sda/sda1
UDEV  [1158015428.924473] umount@/block/sda/sda1

It says nothing when I insert a CD in the readers.

Any idea ?
Should it generate an event for sr0 ?

TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam09 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT

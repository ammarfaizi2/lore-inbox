Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUH3WuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUH3WuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUH3WuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:50:20 -0400
Received: from smtp08.auna.com ([62.81.186.18]:34020 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S265098AbUH3WuP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:50:15 -0400
Date: Mon, 30 Aug 2004 22:50:13 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: microcode_ctl vs udev
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.4
Message-Id: <1093906213l.24821l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I have a little problem with microcode_ctl and udev.
Mandrake 10.1 Cooker has switched fully to udev, and microcode_ctl fails
to open the 'microcode' device.

It looks like udev creates /dev/microcode, but microcode_ctl looks for
/dev/cpu/microcode.

Which is the right location ?

Versions:
werewolf:~# rpm -q udev microcode_ctl
udev-030-10mdk
microcode_ctl-1.08-1mdk

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Beta 1) for i586
Linux 2.6.8.1 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #1



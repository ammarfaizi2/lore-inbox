Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTLQIya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 03:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTLQIy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 03:54:29 -0500
Received: from mta.hosting-seguridad.com ([63.246.136.14]:62621 "EHLO
	mta.hosting-seguridad.com") by vger.kernel.org with ESMTP
	id S263775AbTLQIy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 03:54:28 -0500
Message-ID: <55791.80.58.1.46.1071651267.squirrel@www.hosting-seguridad.com>
Date: Wed, 17 Dec 2003 09:54:27 +0100 (CET)
Subject: Any workaround for mounting an image file (with loop device) which resides on NTFS?
From: <roman@rs-labs.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Scenario: I placed one disk image (image.dd) on a NTFS volume (it's the only
partition where I have some available space) and my idea was to first
mount NTFS partition as /mnt/ntfs, and afterwards mounting
/mnt/ntfs/image.dd (ext3) with loop device.

I'm getting the following error at the second mount command:
ioctl: LOOP_SET_FD: Invalid argument

I googled a bit and it seems to be some kind of incompatibility
between NTFS driver and loop device, as I read in a former thread at lk-ml
(but it didn't clarify how to solve the problem). I tried with a Debian
2.4.18 kernel, but I guess the problem persists on every 2.4.x.
Did you manage to solve this? I wouldn't mind to switch to an experimental
kernel branch, if necessary, since the machine I'm going to use is not in
a production environment. Please, specify clearly with exact version of
the kernel should I download and necessary patches (if any).
TIA.

-R





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTGaSXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 14:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTGaSXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 14:23:38 -0400
Received: from 200-63-154-224.speedy.com.ar ([200.63.154.224]:59838 "EHLO
	runa.sytes.net") by vger.kernel.org with ESMTP id S262464AbTGaSXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 14:23:37 -0400
Message-ID: <48868.127.0.0.1.1059675838.squirrel@webmail.runa.sytes.net>
Date: Thu, 31 Jul 2003 15:23:58 -0300 (ART)
Subject: cdrom related kernel panic
From: lists@runa.sytes.net
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all:

Im using 2.6.0-test2 here (celeron 1.7mhz, 128mb ram and ide cdrom) and
today I experienced reproducible freezes when reading the cdrom.

Everything started when I wanted to get the md5 sum of the cd in the
drive, so I did

md5sum /dev/cdrom

and after some minutes everything froze. I was under X  so I didn't saw
the kernel message.
I rebooted and did the same and it froze again.

Then, I did:

cat /dev/cdrom > /dev/null

in the console and I saw the kernel panic.

I've no idea how to capture that message, since the system is frozen, but
I can write down some data, if you need.


Thanks in advance


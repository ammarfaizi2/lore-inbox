Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbTJ2HKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 02:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTJ2HKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 02:10:06 -0500
Received: from mail.mediaways.net ([193.189.224.113]:24299 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S261905AbTJ2HKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 02:10:03 -0500
Subject: loopback device + crypto = crash on 2.6.0-test7 ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1067411342.1574.11.camel@localhost>
Mime-Version: 1.0
Date: Wed, 29 Oct 2003 08:09:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I wanted to setup a blowfish encrypted file which is then mounted via
loopback. So I did:

losetup -e blowfish /dev/loop0 /file
Password:
mkfs -t ext3 /dev/loop0
mount /dev/loop0 /mnt
<error unknown fs type>
<from here something was seriously broken... could not reboot anymore>

system is:
Linux no 2.6.0-test7 #8 Sun Oct 26 17:00:49 CET 2003 ppc GNU/Linux

(benh rsync tree)

Soeren.


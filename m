Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267207AbSLKQfa>; Wed, 11 Dec 2002 11:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbSLKQfa>; Wed, 11 Dec 2002 11:35:30 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:51072 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267207AbSLKQf3>; Wed, 11 Dec 2002 11:35:29 -0500
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.51: access permission filesystem 0.12
Date: Wed, 11 Dec 2002 17:43:03 +0100
Message-ID: <87lm2wld60.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *untested* patch adds a new permission managing file system.
Furthermore, it adds two modules, which make use of this file system.

One module allows granting capabilities based on user-/groupid. The
second module allows to grant access to lower numbered ports based on
user-/groupid, too.

Changes:
- updated to 2.5.51
- removed fill_empty_from(), now done by security_fixup_ops()

This patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs/>

Regards, Olaf.

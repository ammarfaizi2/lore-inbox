Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbTI3Sqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 14:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTI3Sqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 14:46:51 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:39172 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S261653AbTI3Sqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 14:46:49 -0400
From: Kees Bakker <kees.bakker@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test6] Scratchy sound with via82xx (VT8233)
Date: Tue, 30 Sep 2003 20:46:47 +0200
User-Agent: KMail/1.5.1
Cc: Takashi Iwai <tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309302046.47039.kees.bakker@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with 2.6.0-test6 the sound is (often) not OK. For example,
I let KDE play a sound when email arrives. Often I only hear scratchy
noise, but sometimes sound is OK.

The lcpci output for this device is:
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 10)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 3800
        Flags: medium devsel, IRQ 10
        I/O ports at d000 [size=256]
        Capabilities: [c0] Power Management version 2

I saw the note about dxs_support, but I have the driver built-in. How do I set
dxs_support from the /proc/cmdline?

		Kees


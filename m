Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUAFMiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUAFMiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:38:22 -0500
Received: from [220.110.13.64] ([220.110.13.64]:63997 "EHLO smtp.sscnet.co.jp")
	by vger.kernel.org with ESMTP id S261974AbUAFMiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:38:21 -0500
Message-ID: <3FFAACC7.5A63D5CE@ezinc.com>
Date: Tue, 06 Jan 2004 21:40:39 +0900
From: kernel sunder <kernel@ezinc.com>
X-Mailer: Mozilla 4.78 [ja] (Windows NT 5.0; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: increasing ide1
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running RedHat9.0 with kernel 2.4.23.
Using hdparm (idectl 1 on/off), I can attach or de-attach /dev/hdc.
It's very fine, except increasing ide1.
Like this.

# ls /proc/ide
amd74xx drivers hda hdc ide0 ide1

# idectl 1 off
# idectl 1 on
hdc: MAXTOR XXXXX, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-disk driver.
hdc: host protected area => 1

# ls /proc/ide
amd74xx drivers hda hdc ide0 ide1 ide1

# idectl 1 off
# idectl 1 on
hdc: MAXTOR XXXXX, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-disk driver.
hdc: host protected area => 1

# ls /proc/ide
amd74xx drivers hda hdc ide0 ide1 ide1 ide1

How do I stop increasing ide1?

nickey
kernel@ezinc.com

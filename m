Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTECCBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 22:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTECCBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 22:01:37 -0400
Received: from web20404.mail.yahoo.com ([66.163.169.92]:35386 "HELO
	web20416.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263228AbTECCBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 22:01:33 -0400
Message-ID: <20030503021359.94789.qmail@web20416.mail.yahoo.com>
Date: Fri, 2 May 2003 19:13:58 -0700 (PDT)
From: Hao Zhuang <jerrey2000@yahoo.com>
Subject: Fasttrak66 hangs with ACPI built in (2.4.18, 20)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, all,

i tried to build in ACPI support for kernel 2.4.18 and
20. i have a Fasttrak66 raid and 3 other IDE disks. as
long as i build in ACPI and enable any IDE devices,
the bootup hangs before (or while, i guess) probing
IDE for the device on Fasttrak66. say, every time the
screen frozes as:

    ... ...
    hda: ... /* my IDE disk 1 */ ...
    hdc: ... /* my IDE disk 2 */ ...
    hdd: ... /* my IDE disk 3 */ ...

(if boot up normally, there should be hde: and hdg:
follow to show my harddisks connected to Fasttrak).

however, everything works fine if

    either: no ACPI built-in
    or:     i disable all the IDE disks (hda - hdd).

i'm using ASUS mobo CUSL2, BIOS version 1009.

thanks a lot for your precious time !

- hao

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com

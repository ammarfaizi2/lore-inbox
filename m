Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbUAJPkd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUAJPkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:40:33 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:14830 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S265182AbUAJPkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:40:32 -0500
Message-ID: <40001CEE.5050206@bluewin.ch>
Date: Sat, 10 Jan 2004 16:40:30 +0100
From: Mario Vanoni <vanonim@bluewin.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, it, fr-fr, de-de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.6.1-mm2: compiler warning
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P4-3066HT with 1GB mem

Compiling the kernel under 2.6.1-mm2, gcc-3.3.2
(same messages as under 2.6.1-rc1-mm1, re-tested),

arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff

but compiles.

Rebooting with this kernel (2 times tested)
then trying to recompile the kernel,
no crashes as with 2.6.1-rc2-mm1.
Every time using the last compiled bzImage.

Mario, _not_ in lkml.




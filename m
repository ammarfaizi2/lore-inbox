Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265866AbUA1G4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 01:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUA1G4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 01:56:08 -0500
Received: from mail08a.verio.de ([213.198.55.73]:63648 "HELO mail08a.verio.de")
	by vger.kernel.org with SMTP id S265866AbUA1G4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 01:56:06 -0500
Message-ID: <40175CF0.9030903@physik.de>
Date: Wed, 28 Jan 2004 07:55:44 +0100
From: Detlef Schmicker <d.schmicker@physik.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Lost characters on serial console
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we loose characters on the serial consol during receiving at 115kbaud. 
Especially if
the ide harddisk is used during reception.

We use a 300MHz Goede MediaGX, with a 16550A serial port (16 byte FIFO). We
tuned the Harddisk with hdparm, which reduced the problem, but it still 
exists.

We tried several Kernels: 2.4.4, 2.4.20, 2.4.24 and 2.6.0 and several 
patches "preempt" and "low-lattency".
No changes at all.
We used ext2 and ReiserFS file system.

There were some messages on this problem in the mailing list, but they 
are years old and we did not find
real hints, how to solve.

Can anybody help, can we help with debugging, testing?

Thanks a lot
Detlef Schmicker


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131709AbRC0Weh>; Tue, 27 Mar 2001 17:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131726AbRC0Wea>; Tue, 27 Mar 2001 17:34:30 -0500
Received: from m1smtpisp03.wanadoo.es ([62.36.220.63]:58582 "EHLO
	smtp.wanadoo.es") by vger.kernel.org with ESMTP id <S131666AbRC0Wcp>;
	Tue, 27 Mar 2001 17:32:45 -0500
Message-ID: <3AC10734.36D2593C@wanadoo.es>
Date: Tue, 27 Mar 2001 23:33:40 +0200
From: Javi Roman <javiroman@wanadoo.es>
X-Mailer: Mozilla 4.75 [es] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 and initrd problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with kernel 2.4.0 and my initrd image.

I have a 500 KB bzImage, and I have a 1.200 KBytes initrd image.
My sistem have 8 MB RAM memory. When I init my bzImage from a
MSDOS floppy with this command:

 loadlin bzImage initrd=myinitrd.img

I obtain this error:

"initrd extends beyon end of memory (0x007fff0e > 0x00700000)"
"disabling initrd"


So I can not use my ramdisk image. This problem avoid if I use
any 2.2.x kernel image.


What's happen?


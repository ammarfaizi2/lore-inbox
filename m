Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268710AbTGIXMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268711AbTGIXMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:12:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:51704 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S268710AbTGIXMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:12:31 -0400
Message-ID: <3F0CA554.5090602@mailbox.tu-dresden.de>
Date: Thu, 10 Jul 2003 01:29:24 +0200
From: Stefan Ziegenbalg <stefan.ziegenbalg@mailbox.tu-dresden.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: German, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: raw1394_loop_iterate hangs with 2.4.21
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after installing the 2.4.21 kernel I have the following problem:

My computer hangs, when I press the exit button (of the window 
decoration) during raw1394_loop_iterate is running (mouse pointer dosn't 
move, keyboard dons't react, ...)

This happens in a small GTK 1.2 programm for capturing images form a
dcam. raw1394_loop_iterate is called by an idle function (gtk_idle_add).
That means the computer does not always hang, only when
raw1394_loop_iterate is running durning pressing the exit button
(probability approx. 50%) When it hangs, the function connected with the
"destroy" signal (gtk_signal_connect ...) is never reached.

Versions:
Linux: 2.4.31
libraw: 0.9.0
gtk: 1.2.10
X (don't laugh): 3.3.4

Computer: Tyan S2466 with 2 x Athlon 1533 MHz + 2 GB RAM (SMP and
Highmem support)

Any suggestions? Do you need more info (.config file)?


Regards Stefan










-- 
mailto:stefan.ziegenbalg@mailbox.tu-dresden.de
http://www.sziegenbalg.de
http://www.simage.org


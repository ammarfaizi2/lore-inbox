Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbTGAHU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 03:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbTGAHU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 03:20:29 -0400
Received: from mail3.netbeat.de ([62.208.140.20]:10945 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S266025AbTGAHU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 03:20:28 -0400
Message-ID: <3F01397B.7060109@gmx.de>
Date: Tue, 01 Jul 2003 09:34:19 +0200
From: =?ISO-8859-1?Q?Cornelius_K=F6lbel?= <cornelius.koelbel@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030601
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in Kernel 2.4.20-8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using Kernel 2.4.20. I admit, it is the kernel of RedHat 9.
I hope this is not, because RedHat did so much changes to the Kernel

I was just typing a mail, when the caps lock light and the scroll lock light went on.
Nothing happend anymore. No mouse, no keyboard.
I resetted the computer.

After that, I found the attached output in the /var/log/messages.
I am running cyurs-imapd, I am not sure, if it is due to cyrus.

If the buffer.c might have something to do with the filesystem:
I am using the ext3 filesystem, I have ide and scsi-drives in my system.
Here is an extract of lsmod:
ext3                   69984   4
jbd                    51220   4  [ext3]
sym53c8xx              67376   1
sd_mod                 13324   2
scsi_mod              106168   2  [sym53c8xx sd_mod]

If you need any furhter information I will provide it.

Regards
Corneius



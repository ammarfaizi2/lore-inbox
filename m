Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbTJLHzL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 03:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263431AbTJLHzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 03:55:11 -0400
Received: from [204.97.230.36] ([204.97.230.36]:1042 "HELO gawab.com")
	by vger.kernel.org with SMTP id S263430AbTJLHzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 03:55:07 -0400
Message-ID: <3F890894.7080200@gawab.com>
Date: Sun, 12 Oct 2003 05:53:56 -0200
From: Ivo Santos Cavalcante Carneiro <iscc@gawab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: scsi emulation error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm unable to mount cdrom on my system when using ide-scsi. Using 
ide-cdrom works fine. I first saw this problem on 2.4.21. I'm using 
2.4.22, tested 2.4.23-pre7 and the problem exist yet. This is a short 
description of the system:

asus A7V8X-X mobo
LG CD-ROM CRD-8400B (rev. 1.08)
kernel 2.4.22 on Debian Woody


These are the error messages took from kernel log:
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding 
data
ide-scsi: [[ 28 0 0 0 0 5f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding 
data
ide-scsi: [[ 28 0 0 0 0 60 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding 
data
ide-scsi: [[ 28 0 0 0 0 61 0 0 1 0 0 0 ]
]

...  many times, and then:

ide-scsi: expected 2048 got 4096 limit 2048
Unable to identify CD-ROM format.

Can you help?



TIA,
Ivo


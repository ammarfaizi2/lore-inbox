Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUHGQud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUHGQud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 12:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUHGQud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 12:50:33 -0400
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:993
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S263733AbUHGQuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 12:50:32 -0400
Message-ID: <41150848.6050601@freemail.hu>
Date: Sat, 07 Aug 2004 18:50:16 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: For users of Fedora Core releases <fedora-list@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Different . and .. directories on ext3 made with x86-64 mke2fs?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual-boot machine with FC1/i386 and FC2/x86-64 installed.
They share /home and /tmp but have different / , /boot , /var , /usr
partitions. Recently I almost filled up my /home but I needed still more
space and mounted my x86-64 partitions under i386 FC1.

This message bothers me when I start mkisofs in a directory that is on
a partition that was mke2fs'd under x86-64 FC2:

Unknown file type (unallocated) ./.. - ignoring and continuing.

The burned ISOs are OK, but what's with this "./.." file?

Best regards,
Zoltán Böszörményi


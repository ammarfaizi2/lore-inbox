Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTHYV2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTHYV2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:28:55 -0400
Received: from mail.skjellin.no ([80.239.42.67]:22683 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262260AbTHYV2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:28:53 -0400
Message-ID: <3F4A7F8F.1070602@tomt.net>
Date: Mon, 25 Aug 2003 23:28:47 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030820 Mozilla Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: about [PATCH] Allow sysrq() via /proc/sys/kernel/magickey
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<http://linux.bkbits.net:8080/linux-2.4/cset@1.1114?nav=index.html|ChangeSet@-2d>

"It's in -wolk for a long time and also in some other kernel tree forks.
2.5/2.6 has almost the same (/proc/sysrq-trigger)"

/proc/sysrq-trigger is also in recent 2.4 (it got added in 2.4.21-pre, 
see <http://linux.bkbits.net:8080/linux-2.4/cset@1.930.74.2>). this 
patch just duplicates functionality.

root@testing-builder /proc # uname -a
Linux testing-builder 2.4.22-rc2-s3 #2 Thu Aug 21 18:11:16 CEST 2003 
i686 GNU/Linux

root@testing-builder /proc # ls -l sysrq-trigger
--w-------    1 root     proc            0 Aug 25 23:23 sysrq-trigger

-- 
Cheers!
André Tomt
andre@tomt.net


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVEOTLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVEOTLw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 15:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVEOTLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 15:11:52 -0400
Received: from mta-fs-be-04.sunrise.ch ([194.158.229.33]:19114 "EHLO
	mail-fs.sunrise.ch") by vger.kernel.org with ESMTP id S261204AbVEOTLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 15:11:50 -0400
Message-ID: <42879F6F.6040008@email.it>
Date: Sun, 15 May 2005 21:13:51 +0200
From: Fabio Rosciano <malmostoso@email.it>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050401)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.12-rc4] Oops in reiserfs_panic [please CC]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I have tried to compile 2.6.12-rc4 on my iBook G4 running Debian Sid, 
with custom 2.6.9 kernel.
2.6.9 works absolutely wonderful on this machine, so I used the same 
.config file to compile 2.6.12-rc4, downloaded as a complete tarball.
Upon rebooting with the new kernel, my reiserfs partition (/ actually) 
is correctly seen and checked, but then (before syslogd starts) I get an 
Oops. I transcribe here the first lines:

REISERFS: panic
Kernel BUG in reiserfs_panic at fs/reiserfs/panic.c:362!
Oops: Exception in kernel mode, sig:5 [#1]

If you need any other info I will be glad to report them. Thanks for any 
help.

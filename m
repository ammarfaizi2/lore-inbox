Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291027AbSAaLbZ>; Thu, 31 Jan 2002 06:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291026AbSAaLbQ>; Thu, 31 Jan 2002 06:31:16 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:26267 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291024AbSAaLa4>; Thu, 31 Jan 2002 06:30:56 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] accessfs v0.3 - 2.5.3
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 31 Jan 2002 12:30:36 +0100
Message-ID: <87vgdihi5f.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

accessfs is a new file system to control access to system resources.
Currently it controls access to inet_bind() with ports < 1024 and raw
sockets only.

With this patch, there's no need anymore to run internet daemons as
root. You can individually configure which user/program can bind to
ports below 1024.

Changes:
- diff against linux 2.5.3

The patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs-2.5.3-0.3.diff.gz>

Regards, Olaf.

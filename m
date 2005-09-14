Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbVINUSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbVINUSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbVINUS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:18:26 -0400
Received: from NS8.Sony.CO.JP ([137.153.0.33]:49118 "EHLO ns8.sony.co.jp")
	by vger.kernel.org with ESMTP id S932726AbVINUSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:18:23 -0400
Message-ID: <4328850B.3070808@sm.sony.co.jp>
Date: Thu, 15 Sep 2005 05:16:11 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: hirofumi@mail.parknet.co.jp
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 0/1][FAT] miss-sync issues on sync mount
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I and co-worker realized that some syscalls like
write and utime issue block I/Os after syscall done,
with sync-mounted FAT.

I'll send out two patches following this E-mail, to fix
these issues.

	[1/2]  fat-sync-write.patch
	[2/2]  fat-sync-attr.patch

---
Hiroyuki Machida


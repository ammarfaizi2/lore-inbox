Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161201AbWGIWYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161201AbWGIWYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbWGIWYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:24:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:36062 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161201AbWGIWYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:24:49 -0400
Subject: [2.6.17-mm3] reiser4 breakage
From: PrXenoN <prx@cinatas.ath.cx>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 29 Jun 2006 06:27:01 +0200
Message-Id: <1151555221.7088.9.camel@prxenon>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:80ab310fced15248f8e2da3e2d36cb52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for me reiser4 seems broken since 2.6.17-mm3. During bootup of the
system i reach the initscripts, but then complains about FS problems. I
did fsck.reiser4 and even rebuild my fs with it (as was suggested by the
tool). Some errors were found and fixed, but i still cannot bring the
system up.

After the line

reiser4 panicked cowardly: reiser4[pcscd(6982)]: commit_current_atom
(fs/reiser4/txnmgr.c:1062) [zam-597]

follows a kernel panic showing that line once more.
No further data is displayed.

Are there any debug options worth setting?
Please let me know if you need more information.

kind regards
prx


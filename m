Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWHLRAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWHLRAi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWHLRAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:00:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37421 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964885AbWHLRAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:00:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=LZ5KAIb/gbjSY0n1dFhIxHCZ4hp+K0JQigNCM8iF/vFLvYLrum6wk6QvnJQXUdFwL2ds+nEg9p7DlxUDvi7ETok8ohXhXS2+LFI/qazxEzR0OLoJt+z4tJa71pX6F7KxZMyNZW03I990F0fTyhQafuf2QSUGB2/xUVAvoeiXPNA=
Message-ID: <44DE0959.2030001@gmail.com>
Date: Sat, 12 Aug 2006 19:01:13 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       David Woodhouse <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] [PATCH 0/10] Removal of old code
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes old code.

The patches are against latest -mm snapshot.

 drivers/video/sis/init.h       |    7 -
 drivers/video/sis/init301.h    |    7 -
 drivers/video/sis/initextlfb.c |    4
 drivers/video/sis/osdef.h      |    4
 drivers/video/sis/sis_accel.c  |   26 ----
 drivers/video/sis/sis_accel.h  |   16 --
 drivers/video/sis/sis_main.c   |  226 -----------------------------------------
 drivers/video/sis/sis_main.h   |   63 -----------
 drivers/video/sis/vgatypes.h   |    2
 fs/jffs2/jffs2_fs_i.h          |    2
 10 files changed, 4 insertions(+), 353 deletions(-)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)



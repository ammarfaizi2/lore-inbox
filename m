Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUJAPpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUJAPpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUJAPnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:43:13 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:11442 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261474AbUJAPmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:42:19 -0400
Message-ID: <9e4733910410010842341f347d@mail.gmail.com>
Date: Fri, 1 Oct 2004 11:42:18 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: PATCH: document DRM ioctl use
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document DRM's usage of 'd' as its ioctl identifier. This can't be
changed, it is in every X server.

===== Documentation/ioctl-number.txt 1.13 vs edited =====
--- 1.13/Documentation/ioctl-number.txt 2004-06-18 02:53:41 -04:00
+++ edited/Documentation/ioctl-number.txt       2004-10-01 11:36:28 -04:00
@@ -117,6 +117,7 @@
                                        <mailto:natalia@nikhefk.nikhef.nl>
 'c'    00-7F   linux/comstats.h        conflict!
 'c'    00-7F   linux/coda.h            conflict!
+'d'    00-FF   linux/char/drm/drm/h    conflict!
 'd'    00-1F   linux/devfs_fs.h        conflict!
 'd'    00-DF   linux/video_decoder.h   conflict!
 'd'    F0-FF   linux/digi1.h

-- 
Jon Smirl
jonsmirl@gmail.com

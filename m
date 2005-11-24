Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030603AbVKXFRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbVKXFRY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030605AbVKXFRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:17:24 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:39866 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030603AbVKXFRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:17:23 -0500
Subject: 2.6.14-rt4: via DRM errors
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Dave Airlie <airlied@gmail.com>,
       "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 23:53:05 -0500
Message-Id: <1132807985.1921.82.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed these in dmesg after running "glxgears":

[drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
[drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
[drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
[drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
[drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
[drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
[drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
[drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held
[drm:via_pci_cmdbuffer] *ERROR* via_pci_cmdbuffer called without lock held
[drm:via_cmdbuffer] *ERROR* via_cmdbuffer called without lock held

I was able to intermittently reproduce the messages by launching
glxgears and moving the window around.

Lee


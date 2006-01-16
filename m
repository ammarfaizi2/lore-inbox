Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWAPBf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWAPBf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 20:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWAPBf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 20:35:29 -0500
Received: from linares.terra.com.br ([200.176.10.195]:44935 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S932154AbWAPBf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 20:35:29 -0500
X-Terra-Karma: -2%
X-Terra-Hash: 41e77e8c259b0229ceaf3c0c5f0bf02d
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Organization: Shuffle Experiments
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix rwlock usage example
Date: Sun, 15 Jan 2006 23:34:25 -0200
User-Agent: KMail/1.6.2
Cc: gud@eth.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hgvyDSdDvUhX66x"
Message-Id: <200601152334.25052.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hgvyDSdDvUhX66x
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,

This is a trivial patch which fixes a typo on rwlock usage under 
Documentation/spinlocks.txt.

Signed-Off-By: Lucas Correia Villa Real <lucasvr@gobolinux.org>

-- 
Lucas
powered by /dev/dsp

--Boundary-00=_hgvyDSdDvUhX66x
Content-Type: text/x-diff;
  charset="us-ascii";
  name="03-Documentation-spinlocks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="03-Documentation-spinlocks.patch"

--- linux-2.6.15-git11/Documentation/spinlocks.txt	2006-01-03 01:21:10.000000000 -0200
+++ linux-2.6.15-git11-lucasvr/Documentation/spinlocks.txt	2006-01-15 23:09:28.000000000 -0200
@@ -9,7 +9,7 @@ removed soon. So for any new code dynami
    static int __init xxx_init(void)
    {
    	spin_lock_init(&xxx_lock);
-	rw_lock_init(&xxx_rw_lock);
+	rwlock_init(&xxx_rw_lock);
 	...
    }
 

--Boundary-00=_hgvyDSdDvUhX66x--

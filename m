Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUFNRVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUFNRVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUFNRVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:21:50 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:2486 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S263609AbUFNRVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:21:49 -0400
Date: Mon, 14 Jun 2004 19:21:37 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Fix PME bits in pci.txt
Message-ID: <20040614172137.GA22012@k3.hellgate.ch>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.7-rc3-bk6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.7-rc3-bk6/Documentation/power/pci.txt.orig	2004-06-14 18:54:24.793573267 +0200
+++ linux-2.6.7-rc3-bk6/Documentation/power/pci.txt	2004-06-14 18:54:40.962133902 +0200
@@ -286,11 +286,11 @@
 +------------------+
 |  Bit  |  State   |
 +------------------+
-|  15   |   D0     |
-|  14   |   D1     |
+|  11   |   D0     |
+|  12   |   D1     |
 |  13   |   D2     |
-|  12   |   D3hot  |
-|  11   |   D3cold |
+|  14   |   D3hot  |
+|  15   |   D3cold |
 +------------------+
 
 A device can use this to enable wake events:


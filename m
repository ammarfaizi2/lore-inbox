Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTKFEkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 23:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbTKFEkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 23:40:16 -0500
Received: from evrtwa1-ar2-4-35-049-074.evrtwa1.dsl-verizon.net ([4.35.49.74]:31616
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S263364AbTKFEkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 23:40:12 -0500
Message-ID: <3FA9D0A7.1060609@candelatech.com>
Date: Wed, 05 Nov 2003 20:40:07 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: trivial@rustcorp.com.au
Subject: [PATCH] 2.4.22-pre9, update CodingStyle hits for Emacs users.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Depending on one's default emacs settings, the suggestion in the
CodingStyle may or may not work.  This patch adds a few more commands
to ensure it works in more cases.


--- linux-2.4.22/Documentation/CodingStyle	2001-09-09 16:40:43.000000000 -0700
+++ linux-2.4.22.p4/Documentation/CodingStyle	2003-10-12 18:52:03.000000000 -0700
@@ -184,6 +184,8 @@
    (interactive)
    (c-mode)
    (c-set-style "K&R")
+  (setq tab-width 8)
+  (setq	indent-tabs-mode t)
    (setq c-basic-offset 8))

  This will define the M-x linux-c-mode command.  When hacking on a



-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



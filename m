Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274815AbTHFD4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 23:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274819AbTHFD4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 23:56:17 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:9416
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S274815AbTHFD4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 23:56:16 -0400
Message-ID: <3F307C5F.7010708@candelatech.com>
Date: Tue, 05 Aug 2003 20:56:15 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PATCH:  CodingStyle for xemacs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I change my linux-c mode thus, it actually gets rid of spaces
and uses tabs as preferred:

--- linux-2.4.21/Documentation/CodingStyle	2001-09-09 16:40:43.000000000 -0700
+++ linux-2.4.21.amds/Documentation/CodingStyle	2003-08-05 20:51:17.000000000 -0700
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



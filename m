Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbTF2PTo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 11:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbTF2PTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 11:19:44 -0400
Received: from web20001.mail.yahoo.com ([216.136.225.46]:52601 "HELO
	web20001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265686AbTF2PTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 11:19:43 -0400
Message-ID: <20030629153401.18476.qmail@web20001.mail.yahoo.com>
Date: Sun, 29 Jun 2003 08:34:01 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: delegating to a cpu
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, 

Currently interrupt handler in our driver uses
tasklet to process some of less important info
to save some interrupt time. But problem is that
tasklet ends up in the same cpu, and second  cpu 
is not taking much of the work. 
1) Is there any mechanism to delegate the less
important work to other cpu an example would really 
help.
2) We dont have multiple interrupts, so please 
dont give irq affinity solution!!
3) Our kernel version is 2.4.19.

I am not subscribed to this list, so please 
mail back at vraghava_raju@yahoo.com.

Raju.

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com

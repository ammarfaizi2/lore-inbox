Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTKTNVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 08:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTKTNVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 08:21:13 -0500
Received: from web41115.mail.yahoo.com ([66.218.93.31]:39564 "HELO
	web41115.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261775AbTKTNVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 08:21:10 -0500
Message-ID: <20031120132108.98157.qmail@web41115.mail.yahoo.com>
Date: Thu, 20 Nov 2003 05:21:08 -0800 (PST)
From: boochireddy Srinivas Reddy <boochireddy@yahoo.com>
Subject: post route hook is hitting twice
To: linux-kernel@vger.kernel.org
Cc: boochireddy@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Iam talking about Red Hat Linux 8.0 3.2-7
  Linux version 2.4.18-14.

I registered a post route hook with
nf_register_hook(), and insmoded it,then I wrote a
small program to send  broadcast packets, then I
observed that pre route hook is getting hit twice.

One more thing I observed that if we send it to Linux
stack (by saying NF_ACCEPT)and in ethereal I observed
only one packet(duplicate packet is not appearing).

What could be the reason in hitting pre route hook
twice, and how stack is distinguishing the duplicate
packet.
Thanks
Srinivas


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUBUWFi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 17:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUBUWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 17:05:38 -0500
Received: from web21202.mail.yahoo.com ([216.136.130.18]:26515 "HELO
	web21202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261620AbUBUWFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 17:05:37 -0500
Message-ID: <20040221220536.34801.qmail@web21202.mail.yahoo.com>
Date: Sat, 21 Feb 2004 14:05:36 -0800 (PST)
From: Konstantin Kudin <konstantin_kudin@yahoo.com>
Subject: 2.4.24 - unload/load network module -> unstable network
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I do not know if this is significant, but I'll report
this just in case.

 I was troubleshooting a network problem that
eventually turned out to be unrelated to the linux
box.

 While doing that I unloaded the standard kernel
module for the Broadcom chip {tg3} and loaded
{bcm5700} from the vendor instead. At first things
seemed fine, but after a few hours the box lost the
network and did not respond to ping. The network came
up after a network restart (no reboot). I thought that
there was a problem with bcm5700, so I unloaded it,
and loaded tg3 back. Again, after a few hours the
network went down. So I had to reboot to make network
stable again.

 When the tg3 module is loaded during the boot
sequence, things are stable for indefinite amount of
time.

 Konstantin

__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools

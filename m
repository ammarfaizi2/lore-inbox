Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTI3I2G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTI3I2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:28:06 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:11508 "EHLO
	mailrelay02.tugraz.at") by vger.kernel.org with ESMTP
	id S261196AbTI3I2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:28:04 -0400
From: Thomas Winkler <tom@qwws.net>
Reply-To: tom@qwws.net
To: linux-kernel@vger.kernel.org
Subject: Re: BugReport (test6): USB (ACPI), SWSUSP, E100
Date: Tue, 30 Sep 2003 10:27:37 +0200
User-Agent: KMail/1.5.1
References: <200309291551.00446.tom@qwws.net> <20030929164950.GA27226@ppp0.net>
In-Reply-To: <20030929164950.GA27226@ppp0.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309301027.37763.tom@qwws.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just tested to uhci-hsd one-line patch sent by Wim Van Sebroeck. USB works 
fine again now.

In addition to that the strange e100 problems are also gone now. I double 
checked this by removing the patch once again. Without the patch e100 is 
dead, with the patch everything works fine. Interesting what an USB patch can 
do to a NIC (a side effect of irq problems?).

This only leaves the SWSUP problem open. An 
echo 4 > /proc/acpi/sleep
still shows no effect at all (see also the original mail). Is SWSUP supposed 
to work in test6?

bye,
-- 
Tom Winkler
e-mail: tom@qwws.net

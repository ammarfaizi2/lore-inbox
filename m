Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWDUNbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWDUNbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWDUNbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:31:35 -0400
Received: from webhost66.com ([202.85.141.141]:40631 "EHLO webhost66.com")
	by vger.kernel.org with ESMTP id S932304AbWDUNbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:31:34 -0400
Message-ID: <20060421133139.32090.qmail@webhost66.com>
Reply-To: "=?windows-1251?Q?noip?=" <noip@webhost66.com>
From: "=?windows-1251?Q?noip?=" <noip@webhost66.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic when using iptables NAT rules with kernel 2.6.16.9
Date: Fri, 21 Apr 2006 13:31:39 +0000
MIME-Version: 1.0
X-Mailer: WebMail 2.5
X-Originating-IP: 213.145.98.9
X-Originating-Email: noip@webhost66.com
Content-Type: text/plain; charset="windows-1251"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  
After the upgrade to kernel 2.6.16.9 i'm receiving a kernel panic almost immediately when I enter my iptables REDIRECT rules. If I don't enter these rules, the machine works fine.
I've observed this behavior on all of my machines that are running Broadcom Gbit Ethernet cards using tg3 driver.
On my office machine with the same kernel and the same iptables rules there is no such problem - I have an Intel 10/100 Ethernet card.
My kernel is patched with the Grsecurity patch and with the connlimit patch.
I've tried the same setup without Gresecurity but the problem was still there.
My iptables version is 1.3.5.
 
My kernel config - http://server260.com/panic/kerncfg
A screenshot with the panic - http://server260.com/panic/panic.gif

Please send me a CC on reply because I'm not subscribed to the list.

Thank You
Iavor
 

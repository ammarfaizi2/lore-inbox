Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUCIRJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUCIRJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:09:21 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:9488 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S261252AbUCIRJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:09:20 -0500
Date: Tue, 9 Mar 2004 18:09:45 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, jgarzik@pobox.com
Subject: tg3 error
Message-ID: <20040309170945.GA2039@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A machine at a customer's site (running kernel 2.4.21) has stopped
answering over Ethernet today.  The machine itself was still there and
the customer could log in at the console.  A reboot fixed the problem.

The machine has had these error messages in the syslog about once per
hour for about 24 hours:

Mar  9 16:17:38 mail2 kernel: tg3: eth0: transmit timed out, resetting
Mar  9 16:17:38 mail2 kernel: tg3: tg3_stop_block timed out, ofs=3400 enable_bit=2
Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=2400 enable_bit=2
Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=1400 enable_bit=2
Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=c00 enable_bit=2

The hardware is on-board on an IBM eServer pizza box, a dual broadcom
gigabit ethernet NIC.  Any ideas what might have caused this and what we
should do to prevent this from happening again?

Thanks,

Felix

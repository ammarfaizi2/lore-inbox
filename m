Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVDKTbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVDKTbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVDKTbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:31:13 -0400
Received: from web88012.mail.re2.yahoo.com ([206.190.37.231]:41398 "HELO
	web88012.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261893AbVDKTbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:31:12 -0400
Message-ID: <20050411193108.56141.qmail@web88012.mail.re2.yahoo.com>
Date: Mon, 11 Apr 2005 15:31:08 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: [2.6.12-rc2][suspend] resume occuring twice before suspend to suspend-to-disk
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that when I do a suspend to disk. The
machine suspends PCI devices once (I notice this
because the ipw2200 wireless card shows its
suspending, then it locks/parks the HD heads, but then
all PCI devices are woken up and resume. The HD spins
up and then dumps memory contents to swap partition,
then it suspends all devices again? :)

Is this the right behaviour? 

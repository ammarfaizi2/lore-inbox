Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269081AbUIRBKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269081AbUIRBKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 21:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269082AbUIRBKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 21:10:34 -0400
Received: from zork.zork.net ([64.81.246.102]:21394 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S269081AbUIRBKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 21:10:33 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
References: <20040916024020.0c88586d.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
 linux-kernel@vger.kernel.org
Date: Sat, 18 Sep 2004 02:10:28 +0100
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org> (Andrew Morton's
 message
	of "Thu, 16 Sep 2004 02:40:20 -0700")
Message-ID: <6uwtystm9n.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this in my dmesg after booting 2.6.9-rc2-mm1:

enable_irq(17) unbalanced from c02a1ce5

$ grep ^c02a1c /boot/System.map-`uname -r`
c02a1c10 t e100_up

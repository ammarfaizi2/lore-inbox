Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTI1I7S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 04:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTI1I7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 04:59:18 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:43169 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S262353AbTI1I7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 04:59:17 -0400
Date: Sun, 28 Sep 2003 10:59:02 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: keyboard repeat / sound [was Re: Linux 2.6.0-test6]
Message-ID: <20030928085902.GA3742@k3.hellgate.ch>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
X-Operating-System: Linux 2.6.0-test6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With test6, keyboard repeat takes very noticably longer to kick in after X
has been started (for both X and console). In test5, starting X makes no
difference.

Also, if you move your test5 .config forward and lose sound, you may find
that you now have to enable gameport in input devices to be able to select
(and thus, compile) your sound card driver.

On the up side, the scheduler changes make the infamous xmms skips go away
(for my purposes).

Roger

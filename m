Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267196AbTGTOVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 10:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbTGTOVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 10:21:24 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:27340 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S267196AbTGTOVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 10:21:21 -0400
Date: Sun, 20 Jul 2003 16:36:13 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Subject: APIC support prevents power off
Message-ID: <20030720143613.GA4653@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some UP boards (e.g. ASUS A7A266) enabling support for local APICs keeps
the machine from powering off on shutdown. It will just hang instead.

This has been observed by others before [1]. A warning in the respective
configuration note seems in order (or a proper fix if anybody has one).

Roger

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=105561164424871&w=2

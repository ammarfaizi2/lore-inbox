Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270385AbTG1SRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270386AbTG1SRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:17:09 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:7299 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S270385AbTG1SRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:17:07 -0400
Date: Mon, 28 Jul 2003 20:32:21 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine broken in 2.4.22-pre8 and 2.6.0-pre1&2
Message-ID: <20030728183220.GB30246@k3.hellgate.ch>
Mail-Followup-To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>,
	linux-kernel@vger.kernel.org
References: <3F2515A2.8040008@kmlinux.fjfi.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2515A2.8040008@kmlinux.fjfi.cvut.cz>
X-Operating-System: Linux 2.6.0-test2 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 14:22:58 +0200, Jindrich Makovicka wrote:
> I recently tried 2.6.0-test1, 2.6.0-test2, 2.4.22-pre6 and 2.4.22-pre8, 
> and via-rhine seems broken in all of them. Network connection doesn't 
> work, and only the timeout messages appear:

Does that mean no traffic at all? No ping, no nothing?

> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
> eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
> 
> 2.4.21 still works fine.

Same .config? Is APIC and/or ACPI enabled? Are you running half-duplex?
What other modules do you loaded?

Roger

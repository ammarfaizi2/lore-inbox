Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVDDUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVDDUER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVDDUEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:04:16 -0400
Received: from webmail.topspin.com ([12.162.17.3]:13986 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261366AbVDDUDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:03:42 -0400
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Greg KH <greg@kroah.com>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
X-Message-Flag: Warning: May contain useful information
References: <20050404100929.GA23921@pegasos>
	<87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos>
	<20050404175130.GA11257@kroah.com> <20050404182144.GB31055@pegasos>
	<1112641971.4342.8.camel@cthulhu>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 04 Apr 2005 12:36:12 -0700
In-Reply-To: <1112641971.4342.8.camel@cthulhu> (Ian Campbell's message of
 "Mon, 04 Apr 2005 20:12:48 +0100")
Message-ID: <523bu6gwr7.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Apr 2005 19:36:12.0682 (UTC) FILETIME=[8F25EEA0:01C5394D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Ian> I think what Greg may have meant[0] was that if it bothers
    Ian> you, then you should act by contacting the copyright holders
    Ian> privately yourself in each case that you come across and
    Ian> asking them if you may add a little comment etc, and then
    Ian> submit patches once you have their agreement.

Perhaps another solution would be for someone who has received a
supposedly GPLed Linux kernel from, say, SuSE, to contact SuSE and ask
for the source code to things such as

static u32 tg3FwText[(TG3_FW_TEXT_LEN / sizeof(u32)) + 1] = {
	0x00000000, 0x10000003, 0x00000000, 0x0000000d, 0x0000000d, 0x3c1d0800,
	0x37bd3ffc, 0x03a0f021, 0x3c100800, 0x26100000, 0x0e000018, 0x00000000,
	0x0000000d, 0x3c1d0800, 0x37bd3ffc, 0x03a0f021, 0x3c100800, 0x26100034,
	0x0e00021c, 0x00000000, 0x0000000d, 0x00000000, 0x00000000, 0x00000000,
	0x27bdffe0, 0x3c1cc000, 0xafbf0018, 0xaf80680c, 0x0e00004c, 0x241b2105,
	/* ... */

in drivers/net/tg3.c.  (tg3.c does not contain any license information
at all, and therefore falls under the kernel's GPLv2 license, right?)

 - R.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbUC2OuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 09:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUC2OuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 09:50:17 -0500
Received: from nefty.hu ([195.70.37.175]:9627 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S262892AbUC2OuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 09:50:13 -0500
Date: Mon, 29 Mar 2004 16:50:02 +0200
From: Zoltan NAGY <nagyz@nefty.hu>
X-Mailer: The Bat! (v2.04.7) UNREG / CD5BF9353B3B7091
Reply-To: Zoltan NAGY <nagyz@nefty.hu>
Organization: Nefty Informatics
X-Priority: 3 (Normal)
Message-ID: <1067885681.20040329165002@nefty.hu>
To: linux-kernel@vger.kernel.org
Subject: pdflush and dm-crypt
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've just upgraded the system to 2.6.5-rc2-bk6, and I'm using
dm-crypt. It's a heavily used server, on average 20-30mbit/sec
traffic is on the wire 7/24, and just noticed, that the load is very
high. In every 4-5 sec pdflush takes a lot of cpu... Is this
intentional? I've found a similar question on kerneltrap
(http://kerneltrap.org/node/view/2756), but havent found a solution
yet. I'm just wondering if it is a problem, or it's the normal
behavior? It's a 1.8 P4 with 1G ram and highmem enabled, with 256 bit
aes thru dm-crypt.

Regards,

--
Zoltan NAGY,
Network Administrator



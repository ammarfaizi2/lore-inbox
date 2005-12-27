Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVL0RIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVL0RIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVL0RIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:08:54 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:62651 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751122AbVL0RIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:08:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 0/3] swsusp: swap handling improvements
Date: Tue, 27 Dec 2005 17:47:42 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512271747.43374.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series of patches improves the handling of swap partitions
by swsusp and changes the way it writes the image to swap.  As a result,
the swap-handling part of swsusp is simplified quite a bit.

The patches in this series are also necessary for implementing the swsusp's
userland interface (coming soon).

The third patch has been acked by Pavel, but of course it depends on the
previous two.  Still, I posted them for comments some time ago and there
have not been any, so I assume there are no objections. ;-)

Please apply.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVE0GQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVE0GQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVE0GQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:16:25 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:51151 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S261891AbVE0GQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:16:10 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>
Subject: [RFC] Introducing a new sub-architecture
Date: Fri, 27 May 2005 08:15:56 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66801B76457@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm about to submit a new sub-architecture under arch/cris and I would
like to get your input on how this is best done. I can see at least
3 alternatives:

1. All the patches goes to LKML. Lots of boring patches that most 
people doesn't care about.
2. Send drivers to the driver subsystems maintainers for review 
and then a big .tgz to Andrew.
3. Send the .tgz directly to Andrew without reviews from the
driver guys.

I leaning towards option 2, comments?

Except from the new sub-architecture there will also be patches
to the generic cris parts to add support for e.g. SMP and to
convert to the new IRQ framework.

Thanks!
/Mikael


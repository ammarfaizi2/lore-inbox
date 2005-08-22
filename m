Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVHVUGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVHVUGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVHVUGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:06:15 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18141 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750767AbVHVUGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:06:15 -0400
Message-ID: <430A0B69.1060304@xs4all.nl>
Date: Mon, 22 Aug 2005 19:29:13 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA Rhine ethernet driver bug (reprise...)
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It appears that the VIA Rhine chipset has some sort of bug which shows
up in both the standard Linux VIA-Rhine driver and the Rhinefet driver
that VIA itself provides.

The difference is that the connection is dropped in case of the standard
Linux driver for VIA Rhine but that the connection remains OK with the
Rhinefet driver provided by VIA
(http://www.viaarena.com/downloads/Source/rhinefet.tgz and other places
on viaarena.com...).
So VIA Rhinefet driver consumes more CPU but is also more stable.

I wrote about this issue before: http://lkml.org/lkml/2005/8/7/82 &
http://lkml.org/lkml/2005/1/15/47 etc.
I opened a bugzilla case: http://bugzilla.kernel.org/show_bug.cgi?id=5030

Who could find out why the standard Linux driver chokes and the Rhinefet
driver doesn't? Who could fix this bug?


Kind regards,
Udo


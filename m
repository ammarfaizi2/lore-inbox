Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTISW6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 18:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTISW6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 18:58:11 -0400
Received: from primary.dns.nitric.com ([64.81.197.236]:48390 "EHLO
	primary.mx.nitric.com") by vger.kernel.org with ESMTP
	id S261802AbTISW6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 18:58:09 -0400
To: amartin@nvidia.com
Cc: linux-kernel@vger.kernel.org
From: Merlin Hughes <lnx@merlin.org>
Subject: RE: [PATCH] 2.4.23-pre4 add support for udma6 to nForce IDE driver
Date: Fri, 19 Sep 2003 18:58:06 -0400
Message-Id: <20030919225808.6DE87338D7@primary.mx.nitric.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Allen,

Do you know if an expected side-effect of this patch would
be increased stability? I see that the code does more than
just adding in a new UDMA number, I'm just wondering if the
other changes could be the deliberate cause of the reliability
I'm now seeing.

I have an nforce2 motherboard (Shuttle) with a Maxtor
UDMA133 drive. Operations such as dd if=/dev/hda of=/dev/null
would reliably freeze the machine under 2.4.23-pre4 at
UDMA100; I had to drop to UDMA44 to overcome this.

Since applying your patch, however, I've managed to run such
a dd, with zcav thrown in, with complete relability at UDMA133
for several hours without problems.

Thanks, Merlin

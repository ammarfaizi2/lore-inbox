Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVI3Gyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVI3Gyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVI3Gyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:54:31 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:50816 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S932565AbVI3Gya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:54:30 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: 2.6.14-rc2-git7 crashed on amd64 (usenet gateway) after 18 hours
Date: Fri, 30 Sep 2005 06:54:29 +0000 (UTC)
Organization: Cistron
Message-ID: <dhinf5$skf$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1128063269 29327 62.216.30.70 (30 Sep 2005 06:54:29 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Known story:
last stable kernel for this machine is/was 2.6.12-mm1

Every 2.6.1[34] kernel panics so far.
Sometimes after 40 minutes, sometimes after 4 days.

Config/more info at:
http://newsgate.newsserver.nl/kernel/2.6.14-rc2-git7/

This time it was scsi system again which "blew-up"

Obvious difference i see between 2.6.12 en 2.6.1[34] is that the 
scsi/ethernet cards have different IRQ's set. 
If i'm correct acpi code changed in 2.6.13, right ?

Since the 2.6.12-mm1 kernel survived 3 weeks+ and gave super performance
i'm convinced it's not a hardware issue.

Just giving feedback.

Will try git8 and mm2 and of course report here when they fail.

Danny


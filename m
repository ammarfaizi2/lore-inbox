Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWJPNCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWJPNCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWJPNCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:02:36 -0400
Received: from s3.cableone.net ([24.116.0.229]:5809 "EHLO S3.cableone.net")
	by vger.kernel.org with ESMTP id S1750705AbWJPNCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:02:35 -0400
Message-ID: <16554.129.240.220.12.1161003642.squirrel@peltkore.net>
Date: Mon, 16 Oct 2006 07:00:42 -0600 (MDT)
Subject: [PATCH] IDE: typedef struct clean-up
From: vegard@peltkore.net
To: linux-kernel@vger.kernel.org
Cc: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Jens Axboe" <axboe@kernel.dk>, "Paul Bristow" <paul@paulbristow.net>,
       "Gadi Oxman" <gadio@netvision.net.il>
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-IP-stats: Incoming Outgoing Last 0, First 236, in=997, out=9, spam=0 Known=true
X-External-IP: 24.117.236.111
X-Abuse-Info: Send abuse complaints to abuse@cableone.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vegard Nossum <vegard@peltkore.net>

Replaces typedefs with struct-constructs for large parts of the IDE API
and drivers. No semantic changes. Rationale: CodingStyle, chapter 5.

Signed-off-by: Vegard Nossum <vegard@peltkore.net>
---

Applies to Linus's 2.6 tree.

I figured that this kind of easy/routine job would make for a gentle
introduction to kernel programming. However, what is the general opinion
of this kind of work, should it be done or not? (I realize that I may be
challenging some established habits with these changes.)

Also, what are the rules for enum and function-pointer typedefs?
CodingStyle does not discuss these cases.

Complete patch is 376K and follows as a link. This violates point 6 of
SubmittingPatches (no links), but is justified by point 7 (e-mail size).

http://peltkore.net/~vegard/linux-2.6-ide-typedef-vegard.patch


Regards from Vegard's


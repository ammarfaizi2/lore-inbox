Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbTFCQM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTFCQM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:12:58 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:52609 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S265079AbTFCQM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:12:57 -0400
Subject: [PATCHSET] prerelease of 2.4.21-rc6-dis3
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054657575.12971.38.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Jun 2003 12:26:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new pre-release of 2.4.21-rc6-dis3 for laptops (specifically
Inspiron 8500, but its a lot more general these days) on my site. 

http://www.gotontheinter.net/kernel/ has all the details, but the
biggest change is that non-8500 users don't have to patch it before use
(yay) and there are a couple of patches that should make nvidia users
happier.

Basically anyone with ACPI-only systems can take advantage of at least
some of this (eg swsusp) and laptop users should -really- like it.

Testers very welcome, especially those of you with nvidia cards..

In addition to the rest of the community, big kudos go to Con for his
-ck set (from which some of these patches originated) and both Graeme
and Mike for their work on the i8500.  I think that with -dis3 (and a
solid AML debug pass, since the DSDT it ships is junk) we'll have this
thing beat yet :)

-- 
Disconnect <lkml@sigkill.net>


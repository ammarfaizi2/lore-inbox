Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUFVJaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUFVJaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 05:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUFVJaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 05:30:23 -0400
Received: from guardian.hermes.si ([193.77.5.150]:38160 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S261857AbUFVJaV convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 05:30:21 -0400
Message-ID: <600B91D5E4B8D211A58C00902724252C01BC0700@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: "'Linux-Kernel@vger.kernel.org'" <Linux-Kernel@vger.kernel.org>
Subject: Disk copy, last sector problem
Date: Tue, 22 Jun 2004 11:30:04 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="ISO-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

cat /dev/hda > /dev/hdc

This would not copy the entire disk as expected, but miss the last sector if
the number of
sectors on hda is odd. ( I used "cat" becasue it has the simplest syntax,
"dd" and other behave the same ).
Has this been fixed recently ?
What about suppport of other sectors sizes, like 8kb ?

Regards,
David Bala¾ic

----------------------------------------------------------------------------
-----------
http://noepatents.org/           Innovation, not litigation !
---
David Balazic                      mailto:david.balazic@hermes.si
HERMES Softlab                 http://www.hermes-softlab.com
Zagrebska cesta 104            Phone: +386 2 450 8851 
SI-2000 Maribor
Slovenija
----------------------------------------------------------------------------
-----------
"Be excellent to each other." -
Bill S. Preston, Esq. & "Ted" Theodore Logan
----------------------------------------------------------------------------
-----------









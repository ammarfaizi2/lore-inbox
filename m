Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbVINNRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVINNRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVINNRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:17:53 -0400
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:54255
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S965200AbVINNRx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:17:53 -0400
Subject: Corrupted file on a copy
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 14 Sep 2005 15:14:58 +0200
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <17AB476A04B7C842887E0EB1F268111E026F9B@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Corrupted file on a copy
thread-index: AcW5Lk46hBAimb6ZQvG+LkZwtKW2oA==
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the linux kernel 2.6.10 and busybox 1.0 on a AMD AU1550 board.

When I copy a big file (around 300M) within an ext2 filesystem (even on
ext3 filesystem) then the output file is sometime "corrupted" (I mean
that the source and the destination files are different and thus
generate a different SHA1).
Does somebody have a same behaviour?

Thanks,
David


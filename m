Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTFTJ1a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 05:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTFTJ1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 05:27:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:22783 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262562AbTFTJ13 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 05:27:29 -0400
content-class: urn:content-classes:message
Subject: Problem unmounting initrd-romfs in 2.4.21
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 20 Jun 2003 11:41:25 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <BDB86409B697CB4DBB8A5BF487B9D61A3933@srv01.losekann.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem unmounting initrd-romfs in 2.4.21
Thread-Index: AcM3EBMzMeuhGWeFRnS2h3Li+wuHcQ==
From: "Tobias Reinhard" <T.Reinhard@losekann.de>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I'm booting up with a initrd in a romfs. After loading all needed
modules and pivoting root I unmount the initrd and flush the used
buffers.

Since I updated to 2.4.21 I can't unmount the initrd - it says it's
busy, but it's no (or at least lsof does say so).

I use kernel 2.4.21 with /drivers/Makefile , /drivers/ide and
/include/linux/ide.h from ac1 to reenable ide-modules.

Anyone know the problem?

Tobias


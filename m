Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270080AbTGNNXV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270273AbTGNNWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:22:10 -0400
Received: from mail.siemenscom.com ([12.146.131.10]:14977 "EHLO
	mail.siemenscom.com") by vger.kernel.org with ESMTP id S270591AbTGNMeW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:34:22 -0400
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0179B6D2@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: mmap method implementation question
Date: Mon, 14 Jul 2003 05:49:07 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I jave a device driver which was originaly created for a Kernel 2.4.18-3. It
has an mmap method which uses a call to remap_page_range. In this call, I
pass the in the logical start address, the physical address, the size and
protection mappings. I have upgraded the Kernel to a 2.4.20-8 and now my
remap_page_range call does not compile. It requires me to pass the vma
structure as a first parameter. What changed? Whys is this necessary?

Please CC me directly on any responses.

Thanks in advance, 

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


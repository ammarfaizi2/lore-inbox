Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUGSRCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUGSRCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 13:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUGSRCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 13:02:49 -0400
Received: from mailer.nec-labs.com ([138.15.108.3]:14152 "EHLO
	mailer.nec-labs.com") by vger.kernel.org with ESMTP id S265291AbUGSRCs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 13:02:48 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Ramdisk encryption
Date: Mon, 19 Jul 2004 13:02:37 -0400
Message-ID: <951A499AA688EF47A898B45F25BD8EE80126D4C9@mailer.nec-labs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Ramdisk encryption
Thread-Index: AcRtsjG+7HFJ9VMcRaG36TiI7Kl1rw==
From: "Lei Yang" <leiyang@nec-labs.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can I set up a ramdisk and use loopback encryption to encrypt it?
As far as I understand, the OS will keep data encrypted on the hard 
disk at all times and decrypts it in RAM only as it's read. So an encrypted 
executable on physical hard disk will be decrypted page by page upon
reading to RAM. But what happens to an executable sitting in ramdisk?
Can I also encrypt it? Since the code is in RAM, it should be running in place,
how do kernel deal with encrypted code and run? 

Any comments?

Thanks in advance!
Lei


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWEPIzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWEPIzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWEPIzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:55:50 -0400
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:11024 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1751707AbWEPIzt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:55:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: EDAC MC0: UE page 0x1fffa, offset 0x0, grain 4096, row 0, labels ":": i82875p UE
Date: Tue, 16 May 2006 09:55:47 +0100
Message-ID: <89E85E0168AD994693B574C80EDB9C2703F7749D@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EDAC MC0: UE page 0x1fffa, offset 0x0, grain 4096, row 0, labels ":": i82875p UE
Thread-Index: AcZ4xoY7aoOih3OoQumlqSQQrI70Gw==
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every one of our ASUS P4C800-E and ASUS P4C800 based machines that I've
installed a 2.6.16 smp based kernel on is logging messages of the form:

EDAC MC0: UE page 0x1fffa, offset 0x0, grain 4096, row 0, labels ":":
i82875p UE

every second or so. So I've downgraded them back to 2.6.15. I believe
the message is moaning that the ECC memory has unrecoverable errors.
However, the memory in the machines I've tried passes memtest. And
I'd've expected system hangs which we don't get.

So what's wrong?
 
-- 
Andy, BlueArc Engineering

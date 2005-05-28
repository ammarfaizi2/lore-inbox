Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVE1MV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVE1MV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 08:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVE1MV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 08:21:29 -0400
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:47058 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262719AbVE1MVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 08:21:16 -0400
Message-ID: <007001c56387$235672d0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Sean M. Burke" <sburke@cpan.org>, <linux-kernel@vger.kernel.org>
Cc: <trivial@rustcorp.com.au>
References: <42985251.6030006@cpan.org>
Subject: Re: PATCH: "Ok" -> "OK" in messages
Date: Sat, 28 May 2005 09:14:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Sean M. Burke" <sburke@cpan.org>
To: <linux-kernel@vger.kernel.org>
Cc: <trivial@rustcorp.com.au>
Sent: Saturday, May 28, 2005 07:13
Subject: PATCH: "Ok" -> "OK" in messages


> The English interjection "OK" is misspelled as "Ok" in a dozen
> messages in the Linux kernel.  The following patch corrects
> those typos from "Ok" to "OK".  It affects no comments or
> symbol-names -- and it stops me wanting to gnaw my fingers off every
> time I see "Ok, booting the kernel."!

That's not the most annoying IMO - see how many instances of something like
this you'll sprinkled around:

printk("The PukeMaster is %sabled.\n", SomeFlag ? "dis" : "en");

If a NLS translator isn't a C programmer, they'll screw it up frequently.


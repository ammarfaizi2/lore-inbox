Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVC3Plu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVC3Plu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVC3Plu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:41:50 -0500
Received: from mail29.messagelabs.com ([140.174.2.227]:49381 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S262272AbVC3Plp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:41:45 -0500
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-17.tower-29.messagelabs.com!1112197287!21776465!1
X-StarScan-Version: 5.4.11; banners=-,-,-
X-Originating-IP: [66.77.174.18]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: [ patch 2/5] drivers/serial/jsm: new serial device driver
Date: Wed, 30 Mar 2005 09:41:29 -0600
Message-ID: <335DD0B75189FB428E5C32680089FB9F038ED7@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [ patch 2/5] drivers/serial/jsm: new serial device driver
Thread-Index: AcU1PvCpg0DQs7p4TYmumx6/sGH1fg==
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Wen Xiong" <wendyx@us.ibm.com>, <rmk+lkml@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Wouldn't you think the kernel already takers are of flow control,
given
> that it already handles the sending of the X* characters?

Hi Russell,
 
Yes.
The code was written by me before it was integrated into "serial core".
 
Like your comments suggest, a lot of the "tty" code is now duplicated
because of its integration.

(And yes, its probably overly complex for just a serial driver,
but I was striving for a perfect score in NIST testing...)
 
I believe Wendy plans on continuing to strip out all this duplication of
code.
 
Scott

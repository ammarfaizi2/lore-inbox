Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVCITgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVCITgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVCITgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:36:41 -0500
Received: from minimail.digi.com ([66.77.174.15]:27324 "EHLO minimail.digi.com")
	by vger.kernel.org with ESMTP id S262172AbVCITfv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:35:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ patch 6/7] drivers/serial/jsm: new serial device driver
Date: Wed, 9 Mar 2005 13:35:41 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9EB@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ patch 6/7] drivers/serial/jsm: new serial device driver
Thread-Index: AcUk2/qhv6K5UgXeTeqPixMWt+65aQAAauPw
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Wen Xiong" <wendyx@us.ibm.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > DPA support is a requirement for all Digi drivers, so it would
> > not be possible for me to remove them from my "dgnc" version
> > of the driver.

> "requirement" from whom and to who?  The Linux kernel community?

>From our customers who are moving from other OS's to Linux,
and expect DPA support to be under Linux as well.

> It's not a reservation issue, it's the fact that we don't want to
allow
> new ioctls, and if we do, they had better work properly (your
> implementation does not.)
> 
> thanks,
>
> greg k-h

Which is fine and I accept the blame for.

This is something Wendy can change and fix.
I am explaining why they exist today and my
argument of why we need them to stay.

As it stands today, your requirement appears to be that she needs
to yank all diags ioctls and sysfs files before the driver can make
it into the kernel sources.

This is also fine, but Wendy and IBM will need to decide whether
all our diags utilties are needed for the JSM driver or not.

Scott

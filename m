Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWAEWVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWAEWVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAEWVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:21:45 -0500
Received: from motgate8.mot.com ([129.188.136.8]:27606 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S1751080AbWAEWVn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:21:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Thu, 5 Jan 2006 17:21:38 -0500
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD5D@de01exm64.ds.mot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Thread-Index: AcYSQUYgxRfJPcw9SwiGHtjezi4icQABCU9w
From: "Preece Scott-PREECE" <scott.preece@motorola.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Alan Stern" <stern@rowland.harvard.edu>
Cc: <akpm@osdl.org>, <linux-pm@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We do have multiple system-level low-power modes. I believe today they
differ in turning whole devices on or off, but there are some of those
devices that could be put in reduced-function/lowered-speed modes if we
were ready to use a finer-grained distinction.

This is, of course, in an embedded framework rather than a desktop
framework - we suspend and wakeup automatically, not via user
intervention. Answering a question asked in another piece of mail, we
have roughly a dozen different devices that cause the system to wakeup -
keypad press, touchscreen touch, flip open/close, etc.

And, PCI is totally alien to us...

scott  

-----Original Message-----
From: Pavel Machek [mailto:pavel@ucw.cz] 

Bring example hardware that needs more than two states, implement driver
support for that, and then we can talk about adding more than two states
into core code.

								Pavel


And from another mail:

Out of curiosity, are there really cases where there is > 1 wakeup
device?

--
Thanks, Sharp!

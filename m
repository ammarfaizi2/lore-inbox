Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267616AbUHJTkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267616AbUHJTkx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUHJTkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:40:52 -0400
Received: from smtp1.bae.co.uk ([20.133.0.6]:31672 "EHLO smtp1.bae.co.uk")
	by vger.kernel.org with ESMTP id S267616AbUHJTku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:40:50 -0400
Date: Tue, 10 Aug 2004 20:48:44 +0100
From: "Luesley, William" <william.luesley@amsjv.com>
Subject: RE: Network routing issue
To: "'Paul Jakma'" <paul@clubi.ie>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Message-id: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD7@nmex02.nm.dsx.bae.co.uk>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain;	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> In order to help testing, I have been asked to place a third machine
between
>> these two which will be capable of intercepting and modifying any
messages.

>> My initial plan was to have a device which could mimic both ends of the
>> connection (as I already have code to do this); with each connection
being
>> on a separate NIC, leading to a setup as shown below:
>>
>>          A ------------ C  C  ---------- B
>> 192.168.1.1    192.168.1.2  192.168.1.1   192.168.1.2
>>                    (eth0)  (eth1)

>> Can I use IP Tables, how?
>>
>> Or, am I on totally the wrong track?

>You're on the wrong track. C doesnt even need IP addresses, two 
>choices:

>- C as bridge and use ebtables (C doesnt even need addresses 
>theoretically)

>- C as router, use iptables. C needs one or more addresses which must 
>be different.

My problem is I need to modify the messages before passing them on.  As far
as I'm aware, bridges don't do that - but then I'm a newbie when it comes to
bridging!

********************************************************************
This email and any attachments are confidential to the intended
recipient and may also be privileged. If you are not the intended
recipient please delete it from your system and notify the sender.
You should not copy it or use it for any purpose nor disclose or
distribute its contents to any other person.
********************************************************************

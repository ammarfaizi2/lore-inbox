Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVIMQA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVIMQA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVIMQA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:00:27 -0400
Received: from tiere.net.avaya.com ([198.152.12.100]:42913 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP id S964827AbVIMQA0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:00:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [2.6.12-rc4 patch] Disable queueing when carrier is lost.
Date: Tue, 13 Sep 2005 09:57:40 -0600
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC0858FAD7@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.12-rc4 patch] Disable queueing when carrier is lost.
Thread-Index: AcW33xOzBvZaYlWRQga7tMRbRj/gdAAnI7Pw
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't get a response to a personal e-mail, so forwarding it on to the
LKML for insight.

Thanks!

- Bhavesh 

-----Original Message-----
From: Davda, Bhavesh P (Bhavesh) 
Sent: Monday, September 12, 2005 3:15 PM
To: 'tommy.christensen@tpack.net'
Cc: 'herbert@gondor.apana.org.au'; 'davem@davemloft.net'
Subject: Disable queueing when carrier is lost.


Folks,

Having run into the same issue that you ran into, with the 2.6.11
kernel, I was tempted to do something very similar to this patch that
made it into 2.6.12-rc4.

Before actually "reinventing the wheel" I figured I would google around
for how others are dealing with it, and found out about this just a few
minutes ago.

I was wondering, do you know of any down sides to doing this, and what
can be the up side of queueing on ethernet devices any time the link
(carrier) is lost? I would have thought the "correct" and "safe"
behaviour would be to drop the packets on the floor when the link goes
down, and let upper layers deal with it.

Thanks

- Bhavesh

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com

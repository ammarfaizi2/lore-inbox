Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293343AbSCEPb3>; Tue, 5 Mar 2002 10:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSCEPbT>; Tue, 5 Mar 2002 10:31:19 -0500
Received: from [199.203.178.211] ([199.203.178.211]:21908 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S293343AbSCEPbI> convert rfc822-to-8bit; Tue, 5 Mar 2002 10:31:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="x-user-defined"
Content-Transfer-Encoding: 8BIT
Subject: printk() goes to console.
Date: Tue, 5 Mar 2002 17:30:35 +0200
Message-ID: <DCC3761A6EC31643A3BAF8BB584B26CC0DB95C@exchange.store-age.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: printk() goes to console.
Thread-Index: AcHEWrGfO75qdDA1EdaipgADR78XpQ==
From: "Alexander Sandler" <ASandler@store-age.com>
To: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I am working on block device driver. There is a little problem I am experiencing with it that I'de like to share and also, may be someone may tell me what it can be caused by. I am using printk( KERN_DEBUG ... ) to print different messages about the driver status and then collecting those messages from /proc/kmsg. The problem is that when it prints many messages (like it is printing something for every request it receives), from time to time, those messages getting into system console. Sometimes, I am receiving part of my debug messages printed to console mixed with some junk. 
It's not like it bother me too much. However it still seems to be wrong.
So, does any one has an idea what it can be caused by?

Alexandr Sandler.

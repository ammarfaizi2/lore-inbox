Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbUKKBAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbUKKBAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUKKBAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:00:25 -0500
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:34552 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S262075AbUKKBAV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:00:21 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: The latest module tool issue
Date: Wed, 10 Nov 2004 17:00:17 -0800
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AEC@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Welcome to linux-kernel
thread-index: AcTHh9i7Q23R9MxTRjSe1HcUBFtHJQAADNEw
From: <yiding_wang@agilent.com>
To: <linux-kernel@vger.kernel.org>
Cc: <yiding_wang@agilent.com>
X-OriginalArrivalTime: 11 Nov 2004 01:00:18.0670 (UTC) FILETIME=[CFF678E0:01C4C789]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using moudle-init-tools-3.1-pre6 with kernel 2.6.9. The new insmod seems have restrictions which failed loading driver module with parameters.

My module parameter is in the form of modname="*************** ****", a quite long one.
Run - insmod modname.o modname="*********** *******" (with a script), it complains about the space and treats the string next to the space to be a "Unknown parameter".

By replacing the space with any character, then it complains 
"modname: string parameter too long"

Same parameter string works fine under 2.4.25 with original insmod.

Is this a bug or new insmod has restrictions? If it is restriction, it will bring a lot of trouble. 

Thanks!

Eddie

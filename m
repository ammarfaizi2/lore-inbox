Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbTEFMQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTEFMQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:16:40 -0400
Received: from exch.niss.ac.uk ([212.219.213.39]:51584 "EHLO exch.niss.ac.uk")
	by vger.kernel.org with ESMTP id S262702AbTEFMQB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:16:01 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Failing to allocated file handles?
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Tue, 6 May 2003 13:28:27 +0100
Message-ID: <4AF1125777E862438AF19388C54860C9220566@exch.office.niss.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Failing to allocated file handles?
Thread-Index: AcMTylTHCoTk8AYjSK+c3kwXhvN1hAAABOLQ
From: "Jamie Harris" <jamie.harris@eduserv.org.uk>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, 

Thanks for the response...

> Seems wildly improbable. And if you've reached the max file 
> limit you set why do you expect the kernel to exceed it. 

That's the thing, its nowhere near file-max, yet the number
of available file handles hits zero.  File-max was at 235928, 
~2000 file handles were alloacted, the available handles hit
zero but the number allocated didn't increase, if you see what
I mean.

> Given the max files is set based on the system memory I'd put 
> my bet on it being a low memory box that hits the problem. If 
> so just write a bigger value to the setting

2GB RAM, lots available

[root@cuboid logs]#  free
             total       used       free     shared    buffers
cached
Mem:       2323304    2153068     170236          0     107176
1695984
-/+ buffers/cache:     349908    1973396
Swap:      2097112        832    2096280

Thanks for the response

Jamie...

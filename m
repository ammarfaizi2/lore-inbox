Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWA0S7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWA0S7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWA0S7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:59:49 -0500
Received: from spirit.analogic.com ([204.178.40.4]:2064 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932258AbWA0S7s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:59:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <000601c62370$db00cd50$1701a8c0@gerold>
X-OriginalArrivalTime: 27 Jan 2006 18:59:47.0201 (UTC) FILETIME=[D7997F10:01C62373]
Content-class: urn:content-classes:message
Subject: Re: traceroute bug ?
Date: Fri, 27 Jan 2006 13:59:46 -0500
Message-ID: <Pine.LNX.4.61.0601271352310.14907@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: traceroute bug ?
Thread-Index: AcYjc9e25fkH89d+RUag5S3bFFGF5Q==
References: <000601c62370$db00cd50$1701a8c0@gerold>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Gerold van Dijk" <gerold@sicon-sr.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Jan 2006, Gerold van Dijk wrote:

> Why can I NOT do a traceroute specifically within my own (sub)network
>
> 207.253.5.64/27
>
> with any distribution of Linux??
>
> Gerold@sicon-sr.com
>

Maybe you could explain? Traceroute works fine here....

These are all local:

Script started on Fri 27 Jan 2006 01:53:37 PM EST
[root@chaos client]# traceroute quark
traceroute to quark.analogic.com (10.112.50.12), 30 hops max, 38 byte packets
  1  quark (10.112.50.12)  0.145 ms  0.264 ms  0.174 ms
[root@chaos client]# traceroute boneserver
traceroute to boneserver.analogic.com (10.112.50.10), 30 hops max, 38 byte packets
  1  boneserver (10.112.50.10)  1.633 ms  0.135 ms  0.122 ms
[root@chaos client]# traceroute localhost
traceroute to localhost (127.0.0.1), 30 hops max, 38 byte packets
  1  localhost (127.0.0.1)  0.058 ms  0.045 ms  0.024 ms
[root@chaos client]# traceroute world.std.com
traceroute to world.std.com (192.74.137.5), 30 hops max, 38 byte packets
  1  def-10.112.50.1 (10.112.50.1)  0.625 ms  0.568 ms  0.549 ms
  2  * * *
  3  * * *
  4  *
[root@chaos client]# exit
Script done on Fri 27 Jan 2006 01:55:16 PM EST

Now, with the last one, I attempted to traceroute to something
non-local, outside. The Net Nazis closed all the ports
except mail, ftp, domain, and web so I can't send anything
outside to a non-standard port (like traceroute does) so
it fails with the "* * *"


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

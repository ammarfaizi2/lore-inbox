Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUKZX5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUKZX5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbUKZX5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:57:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263076AbUKZTlf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:41:35 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: where do packet Capture Drivers fit? 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 25 Nov 2004 19:06:34 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348111ED723@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: where do packet Capture Drivers fit? 
Thread-Index: AcTS1WYLUyqKxK/ETwOfXB1H6o3l+wAGk5ww
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

I am studying & planning to implement the packet capture drivers.

According what info I gathered from the net and other sources, I
visualize it as follows:-

When interested in specific traffic i.e. to sniff on port 23 (telnet) in
search of passwords or perhaps we want to highjack a file being sent
over port 21 (FTP), whatever the case, rarely do we just want to blindly
sniff all network traffic. Then we enter pcap_compile() and
pcap_setfilter().

First, pcap's filter is more efficient, because it does it directly with
the BPF filter.

So, I imagine the calls to pcap_compile() and pcap_setfilter() functions
will invoke the packet capture driver.

Am I right? How & where do I get the Architecture of the packet capture
driver & where exactly it fits?

Sorry, if I have posted in a wrong place. In such case, do guide me with
the right maillists or site address.

Thanks for the help in advance.

Regards,
Mukund jampala



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTFJXx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTFJXx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:53:28 -0400
Received: from exchange-1.umflint.edu ([141.216.3.48]:54948 "EHLO
	Exchange-1.umflint.edu") by vger.kernel.org with ESMTP
	id S262018AbTFJXx1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:53:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Wrong number of cpus detected/reported
Date: Tue, 10 Jun 2003 20:04:15 -0400
Message-ID: <37885B2630DF0C4CA95EFB47B30985FB0188001A@exchange-1.umflint.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Wrong number of cpus detected/reported
Thread-Index: AcMvkruui86MQQpzSoamMQH5DPB+hwAGcYsA
From: "Lauro, John" <jlauro@umflint.edu>
To: "Timothy Miller" <miller@techsource.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What kernels balance the loads properly?  When I did some simple tests
with a dual Xeon 2.4, I couldn't get it Linux to balance properly.
About 30% of the time it would be off balance with two CPU bound
processes, and that is about the statistical rate.  I think that was
with 2.4.20, but might have been 2.4.18.  With 3 processes, one would
always get an unfair advantage compared to the other two.

> -----Original Message-----
> From: Timothy Miller [mailto:miller@techsource.com]
> Sent: Tuesday, June 10, 2003 5:09 PM
> To: David Schwartz
> Cc: xyko_ig@ig.com.br; linux-kernel@vger.kernel.org
> Subject: Re: Wrong number of cpus detected/reported
> 
> But if the kernel doesn't have HT support, then it won't necessarily
> balance loads properly.
> 

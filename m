Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbUCJPaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUCJPaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:30:25 -0500
Received: from ns.cohaesio.net ([212.97.129.16]:18304 "EHLO ns.cohaesio.net")
	by vger.kernel.org with ESMTP id S262655AbUCJPaR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:30:17 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.3 userspace freeze
Date: Wed, 10 Mar 2004 16:29:41 +0100
Message-ID: <222BE5975A4813449559163F8F8CF503458432@cohsrv1.cohaesio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.3 userspace freeze
Thread-Index: AcQGp+yOKdkbdm3HTRSscL5rUP3eIgADC+NA
From: "Anders K. Pedersen" <akp@cohaesio.com>
To: "Jan Kara" <jack@suse.cz>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I will try this to night; just to make sure I understand you correctly:
You just want me to turn off quotas on all file systems (currently they
are in use on one of them), and it is not necessary to recompile the
kernel without quota support?

Regards,
Anders K. Pedersen

> -----Original Message-----
> From: Jan Kara [mailto:jack@suse.cz] 
> Sent: Wednesday, March 10, 2004 2:59 PM
> To: Anders K. Pedersen
> Cc: Andrew Morton; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.3 userspace freeze
> 
> 
>   Hello,
> 
>   I don't understand much the output of vmstat but just to 
> rule out one
> possibility - can you try whether you will observe deadlocks also when
> you will not have quotas turned on (I've seen that you have at least
> compiled them in the kernel)?
> 
> 								Honza

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWE3WdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWE3WdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWE3WdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:33:01 -0400
Received: from mail.visionpro.com ([63.91.95.13]:23568 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S932529AbWE3WdA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:33:00 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Sharing memory between kernel and user space
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 30 May 2006 15:32:59 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B331A@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Sharing memory between kernel and user space
Thread-Index: AcaEOQFsLZeNVPl8Tw6dY4bvlkakUw==
From: "Brian D. McGrew" <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question about the best way to share memory between user and
kernel space.

Let's say I have a common structure;

struct counter {
	u_long interrupt_counts;
	bool saw_interupt;
}

And I need to be able to modify these elements from both the kernel and
user space.  What is the best way to allocate this???  I've tried
several methods including __get_free_pages, alloc_pages, vmalloc and so
on; and thus far, I'm just confused myself.

Can someone help me out here with a quick example of some sort???

Thanks,

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!


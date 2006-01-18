Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWARHGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWARHGB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWARHGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:06:01 -0500
Received: from [202.125.80.34] ([202.125.80.34]:54549 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1030266AbWARHGA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:06:00 -0500
Subject: clarity on kref needed.
Date: Wed, 18 Jan 2006 12:27:45 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <3AEC1E10243A314391FE9C01CD65429B28BE86@mail.esn.co.in>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCMCIA Lists please
Thread-Index: AcYLlI4SZGZ9qm2WQmiQuRM6Fl+7IwQZz5nA
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear All,

I have gone through kref and am planning to implement then in my usb driver.
please terminate my misconceptions if any by correcting the statements below.

In the call below:
kref_init(&dev->kref);
	sets the refcount in the kref to 1.

kref_put(&dev->kref);
	increment the refcount.

kref_put(&dev->kref, mem_release );
What I understand is when the refcount falls back to '1', only then the mem_release() function will be called.
Is it correct? I mean, when is the mem_release () called i.e. when the refcount is '0' or '1'.

Thanks & Regards,
Mukund Jampala


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWALFnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWALFnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 00:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWALFnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 00:43:24 -0500
Received: from [202.125.80.34] ([202.125.80.34]:11452 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S964869AbWALFnY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 00:43:24 -0500
Subject: Why check_media_change & revalidate if interrupt is there
Date: Thu, 12 Jan 2006 11:06:03 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B28BB91@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-class: urn:content-classes:message
Thread-Topic: Why check_media_change & revalidate if interrupt is there
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Thread-Index: AcYXOhQBS9XrKmVKSVGGe/hzQQQLPg==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel devels,

I have a doubt about the block driver concepts.
Why do I need the check_media_change & revalidate if interrupt is there.
I mean, if my removable media controller generates interrupts whenever the card is inserted or removed, why will I need a additional check like check_media_change & revalidate .

I can always handle the media change through the ISR. Right.
Can someone explain why really I would need these additional functions?

Regards,
Mukund Jampala



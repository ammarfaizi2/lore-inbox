Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTF0UId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 16:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTF0UId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 16:08:33 -0400
Received: from fmr02.intel.com ([192.55.52.25]:10222 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264762AbTF0UI3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 16:08:29 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ipc semaphore optimization
Date: Fri, 27 Jun 2003 13:22:42 -0700
Message-ID: <41F331DBE1178346A6F30D7CF124B24B2A486F@fmsmsx409.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ipc semaphore optimization
Thread-Index: AcM85FvEd7H0GQVWQyib2BHyWcUigAABRGvA
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jun 2003 20:22:43.0422 (UTC) FILETIME=[DD4ACFE0:01C33CE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps the O(1) scheduler is better at handling the thread switches 
> than the old scheduler. Could you include an update of the comments
into 
> your patch?

Yes, our opinion align with your observation as well.  The O(1)
scheduler
handles the ctx much better.

- Ken

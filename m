Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTFWH3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTFWH3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:29:35 -0400
Received: from fmr01.intel.com ([192.55.52.18]:45040 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264262AbTFWH3e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:29:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [BK PATCH] acpismp=force fix
Date: Mon, 23 Jun 2003 00:43:38 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84725A302@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BK PATCH] acpismp=force fix
Thread-Index: AcM5VV30eEo3Z4oORU+2mqDJ7tAD7gAAXRFA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <torvalds@transmeta.com>, <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Jun 2003 07:43:39.0193 (UTC) FILETIME=[2929FA90:01C3395B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Morton [mailto:akpm@digeo.com] 
> >    ACPI: make it so acpismp=force works (reported by Andrew Morton)

> But prior to 2.5.72, CPU enumeration worked fine without 
> acpismp=force. 
> Now it is required.  How come?

(I'm taking the liberty to update the subject, which I accidentally left
blank)

Because 2.4 has that behavior. One objection that people raised to
applying the 2.4 ACPI patch was that it changed that behavior. So I made
an effort to keep it there.

I think out of sheer inertia I also re-added it to the 2.5 tree.
Probably shouldn't have.

Does anyone have a reason why acpismp=force should be in 2.5/6? If not
I'll go ahead and zap it (again), and everyone should just be aware that
this is another way that 2.4 and 2.5 differ.

Regards -- Andy

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbTJCSEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTJCSEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:04:25 -0400
Received: from fmr05.intel.com ([134.134.136.6]:53712 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263741AbTJCSEY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:04:24 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: down_timeout
Date: Fri, 3 Oct 2003 11:03:52 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84702C93004@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: down_timeout
Thread-Index: AcOJuqjBZ7Y66h73TfWJoxiLfhC7RwAHZR0Q
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Matthew Wilcox" <willy@debian.org>, "Yury Umanets" <umka@namesys.com>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Oct 2003 18:03:53.0049 (UTC) FILETIME=[B47C4490:01C389D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Matthew Wilcox
> It's still not great because it doesn't preserve ordering.  
> down_timeout()
> would be a much better primitive.  We have down_interruptible() which
> could be used for this purpose.  Something like (completely 
> uncompiled):

Yeah we proposed this 2 years ago and someone (don't remember who) shot
us down.

Regards -- Andy

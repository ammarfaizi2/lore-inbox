Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTJHJ7C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 05:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTJHJ7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 05:59:02 -0400
Received: from fmr06.intel.com ([134.134.136.7]:48791 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261305AbTJHJ7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 05:59:00 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] incorrect use of sizeof() in ioctl definitions
Date: Wed, 8 Oct 2003 17:58:53 +0800
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8F3283C@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] incorrect use of sizeof() in ioctl definitions
Thread-Index: AcOHs4XoK9QAuwezQsqz1nwTtB99fwFvRU1gAAPxyPA=
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "Andries Brouwer" <aebr@win.tue.nl>
Cc: "Andrew Morton" <akpm@osdl.org>, "Sharma, Arun" <arun.sharma@intel.com>,
       <linux-kernel@vger.kernel.org>, "Matthew Wilcox" <willy@debian.org>
X-OriginalArrivalTime: 08 Oct 2003 09:58:53.0958 (UTC) FILETIME=[C8241A60:01C38D82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I may misunderstand the measurement here. By previous comment from
Matthew Wilcox, I see "Clearly it's too late to change the ioctl
definitions...". Er, so all things like IOR_BAD and size_t are just to
keep current API untouched, while warning subsequent guys right way to
populate ioctls. :) Then the last question is: is it worthy of some
efforts to modify these APIs completely? Maybe the bee just bites
once...

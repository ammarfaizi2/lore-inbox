Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUDASxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUDASxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:53:36 -0500
Received: from fmr04.intel.com ([143.183.121.6]:1959 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263057AbUDASx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:53:26 -0500
Message-Id: <200404011852.i31IqhF12494@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: RE: disable-cap-mlock
Date: Thu, 1 Apr 2004 10:52:44 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQYGACDY2OgZRKMThKtnxULLtiqiAAAEwoA
In-Reply-To: <20040401103425.03ba8aff.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton wrote on Thursday, April 01, 2004 10:34 AM
>
> If it's for access to SHM_HUGETLB

This is the main reason.

> then there was some discussion about
> extending the uid= thing to shm, but nothing happened.  This could be
> resurrected.

We have tried doing that, in fact, I have worked on this on and off for
a while, none of the solutions we came up with are clean enough.


> I guess we could live with sysctl which simply nukes CAP_IPC_LOCK, but
> it has to be the when-all-else-failed option, yes?

Very much agreed, I also very much in agreement with wli that the user
level tool need a major improvement.  These CAP_* hook has been in the
kernel for ages (since 2.4?), but the user land tool seems fossilized.
Last time I tried libcap (about two weeks ago), it segv on me.

- Ken



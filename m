Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbSIWRyw>; Mon, 23 Sep 2002 13:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261173AbSIWRyw>; Mon, 23 Sep 2002 13:54:52 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:29558 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S261165AbSIWRyv>; Mon, 23 Sep 2002 13:54:51 -0400
Message-ID: <794826DE8867D411BAB8009027AE9EB92038DB5A@fmsmsx38.fm.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: Benjamin LaHaise <bcrl@redhat.com>, Shailabh Nagar <nagar@watson.ibm.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@digeo.com>,
       Alexander Viro <viro@math.psu.edu>, linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] adding aio_readv/writev
Date: Mon, 23 Sep 2002 10:59:51 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ben> Only db2 uses vectored io heavily.  Oracle does not, and none of the
open 
ben> source databases do.  Vectored io is pretty useless for most people.

That's not necessary true. As far as I know, the reason oracle doesn't use
vectored io is because the real implementation is not there.

- Ken

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUJGPJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUJGPJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUJGPJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:09:26 -0400
Received: from fmr11.intel.com ([192.55.52.31]:59789 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S266892AbUJGPGD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:06:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Lhms-devel] Re: [PATCH]  no buddy bitmap patch : intro and includes [0/2]
Date: Thu, 7 Oct 2004 08:03:22 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB007ED31D6@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] Re: [PATCH]  no buddy bitmap patch : intro and includes [0/2]
Thread-Index: AcSsfNYHCgTZJDWlRb2nHCtO25pZfgAAbjCg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Hiroyuki KAMEZAWA" <kamezawa.hiroyu@jp.fujitsu.com>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Cc: "linux-mm" <linux-mm@kvack.org>, "LHMS" <lhms-devel@lists.sourceforge.net>,
       "Andrew Morton" <akpm@osdl.org>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>, "Dave Hansen" <haveblue@us.ibm.com>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>
X-OriginalArrivalTime: 07 Oct 2004 15:03:27.0012 (UTC) FILETIME=[CC819E40:01C4AC7E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Followings are patches for removing bitmaps from buddy 
>allocator, against 2.6.9-rc3.
>> I think this version is much clearer than ones I posted a month ago.
>...
>> If there is unclear point, please tell me.
>
>What was the purpose behind this, again? Sorry, has been too long since
>I last looked.
>

For one, it avoids the otherwise requisite resizing of the bitmaps 
during memory hotplug operations...

matt

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWCWFnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWCWFnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWCWFnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:43:53 -0500
Received: from fmr23.intel.com ([143.183.121.15]:15760 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932423AbWCWFnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:43:52 -0500
Message-Id: <200603230543.k2N5hhg22185@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Mark Rustad'" <mrustad@mac.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.16 hugetlbfs problem
Date: Wed, 22 Mar 2006 21:43:58 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZOCT391SUPh0fiSe2TKLfPK0dItwAJLzWA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <EE85F1AA-A258-4D4F-A46F-34253AEE280E@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rustad wrote on Wednesday, March 22, 2006 3:33 PM
> >> I seem to be having trouble using hugetlbfs with kernel 2.6.16. I
> >> have a small test program that worked with 2.6.16-rc5, but fails with
> >> 2.6.16-rc6 or the release. The program is below. Given a path to a
> >> file on a hugetlbfs, it opens/creates the file, mmaps it and tries to
> >> access the first word. On 2.6.16-rc5, it works. On 2.6.16, it hangs
> >> page-faulting until it is killed.
> >
> > On what platform?  Things like hugetlb and address space layout
> > (you're requesting a specific mmap() address I noticed) are very
> > platform specific.
> 
> This is on a Xeon, without PAE with the 1GB no-highmem memory map, in  
> all three cases. This is a 32-bit kernel running on a Nacona CPU. I  
> also had an unmap call over the range to be mmap-ed, but the failure/ 
> success cases were the same, so I removed it to reduce the test  
> program further.

It might be something else happening in your environment. I ran your test
code on a similar system. It ran just fine.

- Ken


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVCVUBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVCVUBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVCVUBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:01:48 -0500
Received: from fmr21.intel.com ([143.183.121.13]:16055 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261571AbVCVUAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:00:07 -0500
Message-Id: <200503221959.j2MJxmg17815@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Daniel McNeil'" <daniel@osdl.org>, "Andrew Morton" <akpm@osdl.org>
Cc: <linuxppc64-dev@ozlabs.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH 2.6.11] AIO panic on PPC64 caused byis_hugepage_only_range()
Date: Tue, 22 Mar 2005 11:59:48 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcUvFOKGMTAr50lwQDW/IhIBnhcdswABH3vw
In-Reply-To: <1111519474.15956.40.camel@ibm-c.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 18:41, Andrew Morton wrote:
> Did we fix this yet?
>

Daniel McNeil wrote on Tuesday, March 22, 2005 11:25 AM
> Here's a patch against 2.6.11 that fixes the problem.
> It changes is_hugepage_only_range() to take mm as an argument
> and then changes the places that call it to pass 'mm'.
> It includes a change for ia64 which has not been compiled.


Just a sanity check, tested the patch on ia64. Nothing blows up
and everything is working.



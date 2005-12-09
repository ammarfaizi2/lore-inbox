Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVLIRRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVLIRRB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVLIRRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:17:01 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:16064 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932296AbVLIRQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:16:58 -0500
Subject: Re: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix
	coding style
From: Dave Hansen <haveblue@us.ibm.com>
To: Mark Rustad <MRustad@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]>
References: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 09:16:49 -0800
Message-Id: <1134148609.30856.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 10:39 -0600, Mark Rustad wrote:
> This patch makes the function make_huge_pte non-static, so it can be used
> by drivers that want to mmap huge pages. Consequently, a prototype for the
> function is added to hugetlb.h. Since I was looking here, I noticed some
> coding style problems in the function and fix them with this patch.

What driver needs to map huge pages?  Is it in the kernel tree now?  If
not, can you post the source, please?

-- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVKAFDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVKAFDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVKAFDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:03:43 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:8570 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932585AbVKAFDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:03:42 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH/RFC] IB: Add SCSI RDMA Protocol
 (SRP) initiator
X-Message-Flag: Warning: May contain useful information
References: <52wtjtk3d1.fsf@cisco.com>
	<20051101110409V.fujita.tomonori@lab.ntt.co.jp>
	<52irvdge6c.fsf@cisco.com> <20051101045800.GA25519@lst.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 31 Oct 2005 21:03:35 -0800
In-Reply-To: <20051101045800.GA25519@lst.de> (Christoph Hellwig's message of
 "Tue, 1 Nov 2005 05:58:00 +0100")
Message-ID: <52acgpgdso.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 01 Nov 2005 05:03:36.0233 (UTC) FILETIME=[9D6F1190:01C5DEA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Christoph> No. Bitfields for accessing hardware/wire
    Christoph> datastructures are wrong and will always break in some
    Christoph> circumstances.  Your header is much better.

OK, that's my feeling as well.

Would it make sense for me to split the pure SRP spec structures and
so on into a separate file and put it in include/scsi/srp.h?  Then we
can move ibmvscsi towards using that file.

 - R.

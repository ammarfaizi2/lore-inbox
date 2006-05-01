Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWEAX1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWEAX1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWEAX1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:27:39 -0400
Received: from test-iport-3.cisco.com ([171.71.176.78]:1309 "EHLO
	test-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751057AbWEAX1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:27:38 -0400
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 2 of 13] ipath - set up 32-bit DMA mask if 64-bit setup fails
X-Message-Flag: Warning: May contain useful information
References: <1906950392f7ef8c7d07.1145913778@eng-12.pathscale.com>
	<ada7j55vayj.fsf@cisco.com>
	<4B05D10C-407E-46A5-848F-0897D1E6D1CD@kernel.crashing.org>
	<adapsixs9rg.fsf@cisco.com>
	<114102B4-FBCB-4A5A-B986-80D4A730DD91@kernel.crashing.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 16:27:36 -0700
In-Reply-To: <114102B4-FBCB-4A5A-B986-80D4A730DD91@kernel.crashing.org> (Segher Boessenkool's message of "Tue, 2 May 2006 01:13:12 +0200")
Message-ID: <aday7xlqqaf.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 23:27:37.0757 (UTC) FILETIME=[D53A3CD0:01C66D76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Segher> And it builds just fine -- what is the problem you're
    Segher> thinking of?

Well, the ipath driver depends on PCI_MSI, and PCI_MSI depends on
(X86_LOCAL_APIC && X86_IO_APIC) || IA64

So how do you enable the driver?

And what powerpc platform can you use the device on?

 - R.

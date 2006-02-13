Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWBMTEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWBMTEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWBMTEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:04:12 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:36655 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964787AbWBMTEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:04:10 -0500
X-IronPort-AV: i="4.02,109,1139212800"; 
   d="scan'208"; a="1775963970:sNHT40118448"
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Badari Pulavarty <pbadari@us.ibm.com>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [openib-general] madvise MADV_DONTFORK/MADV_DOFORK
X-Message-Flag: Warning: May contain useful information
References: <20060213154114.GO32041@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Feb 2006 11:04:02 -0800
In-Reply-To: <20060213154114.GO32041@mellanox.co.il> (Michael S. Tsirkin's
 message of "Mon, 13 Feb 2006 17:41:14 +0200")
Message-ID: <adazmkv13od.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 13 Feb 2006 19:04:07.0418 (UTC) FILETIME=[43B935A0:01C630D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One question, which I'm too lazy to read the source to answer: what
does an old (pre-MADV_DONTFORK) kernel do with an application that
tries to set MADV_DONTFORK?

I'm wondering what portable applications will have to do to handle the
case of a new application running on an old kernel.

Thanks,
  Roland

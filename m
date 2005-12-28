Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVL1BLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVL1BLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 20:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVL1BLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 20:11:52 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:13642 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932437AbVL1BLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 20:11:52 -0500
X-IronPort-AV: i="3.99,299,1131350400"; 
   d="scan'208"; a="384058763:sNHT34380840"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, akpm@osdl.org,
       hch@infradead.org
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
X-Message-Flag: Warning: May contain useful information
References: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 27 Dec 2005 17:11:50 -0800
In-Reply-To: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com> (Bryan
 O'Sullivan's message of "Tue, 27 Dec 2005 15:41:55 -0800")
Message-ID: <adaslsec9ex.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Dec 2005 01:11:50.0874 (UTC) FILETIME=[AEBD6BA0:01C60B4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh yeah:

 > +EXPORT_SYMBOL_GPL(__memcpy_toio32);

I think this is a sufficiently basic facility that it might as well be
plain EXPORT_SYMBOL(), although I don't mind making things harder on
non-GPL modules.

 - R.

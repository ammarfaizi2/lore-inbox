Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVLMQtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVLMQtj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVLMQtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:49:39 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:31677 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932328AbVLMQtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:49:39 -0500
Subject: Re: [Patch] Fix calculation of grow_pgdat_span() in
	mm/memory_hotplug.c
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051213220842.9C02.Y-GOTO@jp.fujitsu.com>
References: <20051213220842.9C02.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 08:49:26 -0800
Message-Id: <1134492566.6448.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 22:20 +0900, Yasunori Goto wrote:
> Dave-san.
> CC: Andrew-san.
> 
> I realized 2.6.15-rc5 still has a bug for memory hotplug.
> The calculation for node_spanned_pages at grow_pgdat_span() is
> clearly wrong. This is patch for it.

Clearly wrong is the term for it.  Thanks for the fix.

-- Dave


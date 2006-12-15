Return-Path: <linux-kernel-owner+w=401wt.eu-S965085AbWLOE60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWLOE60 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 23:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWLOE60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 23:58:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60345 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965085AbWLOE6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 23:58:25 -0500
Date: Thu, 14 Dec 2006 20:57:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm@kvack.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] lumpy reclaim v2
Message-Id: <20061214205734.0e385643.akpm@osdl.org>
In-Reply-To: <6109d33145c0dcf3a8a3a6bd120d7985@pinky>
References: <exportbomb.1165424343@pinky>
	<6109d33145c0dcf3a8a3a6bd120d7985@pinky>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 16:59:35 +0000
Andy Whitcroft <apw@shadowen.org> wrote:

> +			tmp = __pfn_to_page(pfn);

ia64 doesn't implement __page_to_pfn.  Why did you not use page_to_pfn()?

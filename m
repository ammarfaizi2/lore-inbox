Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWDLBWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWDLBWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 21:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWDLBWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 21:22:09 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:8108 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751251AbWDLBWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 21:22:08 -0400
Date: Wed, 12 Apr 2006 10:23:34 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] squash duplicate page_to_pfn and pfn_to_page
Message-Id: <20060412102334.0553cdea.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060411194539.GA2507@shadowen.org>
References: <20060411194539.GA2507@shadowen.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2006 20:45:39 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> squash duplicate page_to_pfn and pfn_to_page
> 
> We have architectures where the size of page_to_pfn and pfn_to_page
> are significant enough to overall image size that they wish to
> push them out of line.  However, in the process we have grown
> a second copy of the implementation of each of these routines
> for each memory model.  Share the implmentation exposing it either
> inline or out-of-line as required.
> 

Thank you for elimination of duplicated codes.

Thanks,
-Kame


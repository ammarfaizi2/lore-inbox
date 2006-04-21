Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWDUTId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWDUTId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWDUTId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:08:33 -0400
Received: from canuck.infradead.org ([205.233.218.70]:22940 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751239AbWDUTIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:08:32 -0400
Subject: Re: [PATCH] Shrink rbtree
From: David Woodhouse <dwmw2@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <4448D8BF.9040601@yahoo.com.au>
References: <1145623663.11909.139.camel@pmac.infradead.org>
	 <4448D8BF.9040601@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 20:08:23 +0100
Message-Id: <1145646503.11909.222.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 23:06 +1000, Nick Piggin wrote:
> How do we know the pointers are always going to be aligned? IIRC
> struct address_space needed to be explicitly aligned when doing
> this trick in page->mapping because some platform byte aligned it.

Really? I've been doing this kind of trick with the jffs2_raw_node_ref
for years. We always allocate sufficiently aligned objects.

-- 
dwmw2


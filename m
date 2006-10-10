Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWJJHUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWJJHUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWJJHUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:20:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20107 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965062AbWJJHUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:20:02 -0400
Subject: Re: 2.6.19-rc1-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 10 Oct 2006 09:20:00 +0200
Message-Id: <1160464800.3000.264.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 00:09 -0700, Andrew Morton wrote:
> +htlb-forget-rss-with-pt-sharing.patch

if it's ok to ignore RSS, can we consider the shared pagetables for
normal pages patch? It saves quite a bit of memory on even desktop
workloads as well as avoiding several (soft) pagefaults.

So.. what does RSS actually mean? Can we ignore it somewhat for
shared-readonly mappings ? 


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com


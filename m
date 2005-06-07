Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVFGUAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVFGUAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVFGUAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:00:16 -0400
Received: from serv01.siteground.net ([70.85.91.68]:22673 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261926AbVFGUAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:00:11 -0400
Date: Tue, 7 Jun 2005 12:59:04 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Christoph Hellwig <hch@infradead.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
In-Reply-To: <20050607194123.GA16637@infradead.org>
Message-ID: <Pine.LNX.4.62.0506071258450.2850@ScMPusgw>
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
 <20050607194123.GA16637@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2005, Christoph Hellwig wrote:

> On Tue, Jun 07, 2005 at 11:30:03AM -0700, christoph wrote:
> > Move syscall table, timer_hpet and the boot_cpu_data into the "mostly_readonly" section.
> 
> the syscall table should be completely readonly.

Why was it in .data in the first place? There must be some reason why it 
was writable?


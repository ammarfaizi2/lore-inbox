Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVHIEHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVHIEHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVHIEHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:07:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932437AbVHIEHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:07:06 -0400
Date: Tue, 9 Aug 2005 00:06:49 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Mel Gorman <mel@csn.ul.ie>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to reclaim inode pages on demand
In-Reply-To: <Pine.LNX.4.58.0508081650160.26013@skynet>
Message-ID: <Pine.LNX.4.61.0508090006150.28169@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.58.0508081650160.26013@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Mel Gorman wrote:

> Given a struct page, that one knows is an inode, can anyone suggest
> the best way to find the inode using it and free it?

Note that you can only free the inodes that aren't currently
open files for any of the processes in the system.

-- 
All Rights Reversed

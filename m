Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUFFOlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUFFOlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 10:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUFFOlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 10:41:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62891 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263709AbUFFOlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 10:41:00 -0400
Date: Sun, 6 Jun 2004 10:39:52 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Con Kolivas <kernel@kolivas.org>, FabF <fabian.frederick@skynet.be>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: why swap at all?
In-Reply-To: <40BF3250.9040901@tmr.com>
Message-ID: <Pine.LNX.4.44.0406061038310.29273-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004, Bill Davidsen wrote:

> My perception is that the system is really bad at recognizing 
> diminishing returns to be had by paging programs for the benefit of i/o. 

Currently the kernel has no mechanisms at all to do any
kind of detection of bad pageout decisions it made in
the past, and consequently no way to learn for the future.

Checks and balances ... those are what's missing ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUJNJZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUJNJZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270009AbUJNJZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 05:25:41 -0400
Received: from science.horizon.com ([192.35.100.1]:20793 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S266613AbUJNJZk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 05:25:40 -0400
Date: 14 Oct 2004 09:25:40 -0000
Message-ID: <20041014092540.5416.qmail@science.horizon.com>
From: linux@horizon.com
To: albert@users.sourceforge.net
Subject: Re: 4level page tables for Linux
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Numbers for all of them would be easy to deal with.
> Like this: pd1, pd2, pd3, pd4...
> 
> I'd number going toward the page, because that's
> the order in which these things get walked.

On the other hand, these extensions tend to get made to the top,
and it's confusing if, in a 2-level system, only pd3 and pd4 are used.

Perhaps a little-endian scheme (pd1 = pte, pt2=pmd, pd4=pgd) would
be better after all.

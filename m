Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267179AbUHDBVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267179AbUHDBVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267176AbUHDBVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:21:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58790 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267184AbUHDBVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:21:41 -0400
Date: Tue, 3 Aug 2004 21:21:34 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040803221121.GN2241@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0408032120570.5948-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Andrea Arcangeli wrote:

> Anyways my overall picture of this is that you're trying to do
> filesystem quotas with rlimit which sounds quite flawed.

This is exactly why named hugetlb files are NOT included
in this accounting, only the ones created through the SHM
interface are.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


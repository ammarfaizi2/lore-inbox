Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267803AbUHERjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267803AbUHERjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUHERjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:39:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45967 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267803AbUHERjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:39:46 -0400
Date: Thu, 5 Aug 2004 13:39:29 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: rddunlap@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] increase mlock limit to 32k
In-Reply-To: <20040805102933.0c95d12a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408051334350.8229-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Andrew Morton wrote:

> Well please note that the initial patch got 100% rejects because it was
> against a kernel which was already using limits of PAGE_SIZE rather than
> zero.  An incremental patch might be saner..

Oh duh, Chris Wright's patch decreased the limits from PAGE_SIZE
to 0 ;(   Sorry about the rejects...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


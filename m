Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUDCUVN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 15:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUDCUVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 15:21:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21946 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261925AbUDCUVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 15:21:09 -0500
Date: Sat, 3 Apr 2004 15:21:03 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: oom-killer adjustments
In-Reply-To: <20040403195440.GB3169@tpkurt.garloff.de>
Message-ID: <Pine.LNX.4.44.0404031520350.30015-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Kurt Garloff wrote:
> On Sat, Apr 03, 2004 at 01:12:07PM -0500, Rik van Riel wrote:
> > Shouldn't such an adjustment be inherited at fork time,
> > if we decide we want it in the kernel ?
> 
> It is inherited. Why do you think it's not?

Oh duh, dup_task_struct() copies everything in 2.6.

ISTR 2.2 or 2.4 was slightly different, copying
(some?) things by hand...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUHFAvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUHFAvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUHFAvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:51:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16015 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268036AbUHFAvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:51:40 -0400
Date: Thu, 5 Aug 2004 20:51:37 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
In-Reply-To: <20040805173650.4e7a8405.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408052048570.8229-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Andrew Morton wrote:

> >  If the current patch isn't effective enough, we may want
> >  to add more code.  However, we may want to try the simplest
> >  possible approach first.
> 
> How do we know whether it is effective enough?  How do we define this?

Good question.  I guess our usual answer is "throw it out there
and wait for somebody to show up with a workload that needs more".

If you want I could add a bit more code proactively, but how do
we find out whether it's really needed ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273298AbTHFChO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273336AbTHFChN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:37:13 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:7291 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S273298AbTHFChH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:37:07 -0400
Date: Tue, 5 Aug 2003 22:37:03 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Scott L. Burson" <gyro@zeta-soft.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <Mathieu.Malaterre@creatis.insa-lyon.fr>
Subject: Re: SMP performance problem in 2.4 (was: Athlon spinlock performance)
In-Reply-To: <16172.14411.843546.121234@kali.zeta-soft.com>
Message-ID: <Pine.LNX.4.44.0308052235520.10520-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003, Scott L. Burson wrote:

> I see that even the very most recent Red Hat kernel (2.4.20-19.7,
> released only two weeks ago) does not seem to have these fixes.

Look again.  The kernel that came with RH9 has pretty much
all of the highmem fixes, the update kernels later on have
them all.

The main difference is that the VM in RH9 is closer to that
of 2.5, so the patches don't look the same.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


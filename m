Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264993AbUD3TEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbUD3TEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUD3TEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:04:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13224 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264993AbUD3TEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:04:11 -0400
Date: Fri, 30 Apr 2004 15:03:59 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
In-Reply-To: <20040430174117.A13372@infradead.org>
Message-ID: <Pine.LNX.4.44.0404301502550.6976-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Christoph Hellwig wrote:

> I'd hate to see this in the kernel unless there's a very strong need
> for it and no way to solve it at a nicer layer of abstraction, e.g.
> userland virtual machines ala uml/umlinux.

User Mode Linux could definitely be an option for implementing
resource management, provided that the overhead can be kept
low enough.

For these purposes, "low enough" could be as much as 30%
overhead, since that would still allow people to grow the
utilisation of their server from a typical 10-20% to as
much as 40-50%.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


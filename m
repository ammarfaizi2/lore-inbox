Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUF0N5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUF0N5U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 09:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUF0N5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 09:57:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15011 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262101AbUF0N5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 09:57:19 -0400
Date: Sun, 27 Jun 2004 09:57:04 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jeff Dike <jdike@addtoit.com>
cc: Christoph Hellwig <hch@infradead.org>,
       BlaisorBlade <blaisorblade_spam@yahoo.it>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Inclusion of UML in 2.6.8
In-Reply-To: <20040627035311.GA8842@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0406270956240.3889-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004, Jeff Dike wrote:
> On Sat, Jun 26, 2004 at 07:10:48PM +0100, Christoph Hellwig wrote:

> > Also your above arch_free_page needs some more discussion.
> 
> I think that can disappear.  In some cases, it might be handy for the
> arch to see pages being freed, but right now, I believe that UML has no
> need for it.

Should be useful for Linux/Xen, Linux/s390 and Linux/iSeries,
too...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


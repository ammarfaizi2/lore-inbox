Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUHJU7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUHJU7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUHJU7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:59:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24025 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267745AbUHJU7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:59:17 -0400
Date: Tue, 10 Aug 2004 16:59:04 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Matt Domsch <Matt_Domsch@dell.com>, <linux-kernel@vger.kernel.org>,
       Ernie Petrides <petrides@redhat.com>
Subject: Re: [PATCH] reserved buffers only for PF_MEMALLOC
In-Reply-To: <20040810195009.GC13509@logos.cnet>
Message-ID: <Pine.LNX.4.44.0408101658071.7156-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Marcelo Tosatti wrote:

> OK, makes sense. I assume Rik's patch fixes the deadlock you are seeing?
> 
> Have you tested it?

It's being tested on RHEL3, where we also ran into another
(trivial) bug that blocks this issue.  It's just one of a
few trivial bugs we ran into and I believe this one needs
fixing ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


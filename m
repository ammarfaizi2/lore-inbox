Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUJLSOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUJLSOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267483AbUJLSLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:11:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266582AbUJLSLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:11:01 -0400
Date: Tue, 12 Oct 2004 14:10:52 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@cpushare.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: secure computing for 2.6.7
In-Reply-To: <20041012174605.GH17372@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0410121409160.13693-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Andrea Arcangeli wrote:

> However as said boinc and seti would better start using it too.

Thinking about it some more, I'm not convinced they can.

After all, they need to get new data to perform calculations
on, and pass the results of previous calculations on to the
server.

In order to do that, the user needs to run code that's not
restricted by seccomp. Taking that into account, what's the
point ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


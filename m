Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUCLTP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUCLTPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:15:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12440 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262418AbUCLTOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:14:53 -0500
Date: Fri, 12 Mar 2004 14:14:35 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <40520B2E.3010806@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0403121413020.6494-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Chris Friesen wrote:

> I'm just thinking of the "fork 100000 kids to test 32-bit pids" sort of
> test cases.

Try that with a process that takes up 2GB of address
space ;)   It won't work now and it'll fail for the
same reasons with the scheme I proposed.

Probably before the 2^44 bits of space run out, too.


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


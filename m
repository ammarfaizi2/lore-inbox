Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVABQpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVABQpL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 11:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVABQpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 11:45:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54955 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261274AbVABQpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 11:45:06 -0500
Date: Sun, 2 Jan 2005 11:44:52 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: VM fixes [4/4]
In-Reply-To: <20050102155107.GB5164@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0501021143580.23180@chimarrao.boston.redhat.com>
References: <20041224174156.GE13747@dualathlon.random>
 <Pine.LNX.4.61.0412270837001.19240@chimarrao.boston.redhat.com>
 <1104226960.27708.321.camel@tglx.tec.linutronix.de> <20050102155107.GB5164@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2005, Andrea Arcangeli wrote:

> The other part of Thomas's change is this one:

> Thomas's changes worked better than previous code so far, he can clearly
> identify forkbombs or services spread across multiple processes.

> optimal. What he does above by killing the childs first is a lot more
> conservative and I'm fine with it as well.

I like it a lot, especially when thinking about overloaded
web servers and other loads that are common but not malicious.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

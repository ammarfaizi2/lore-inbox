Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVBLCEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVBLCEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 21:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVBLCEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 21:04:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:31936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262381AbVBLCDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 21:03:18 -0500
Date: Fri, 11 Feb 2005 18:03:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andrew Morton <akpm@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@twiddle.net>, Ingo Molnar <mingo@elte.hu>
Subject: Re: out-of-line x86 "put_user()" implementation
In-Reply-To: <200502112058_MC3-1-95CC-5FF1@compuserve.com>
Message-ID: <Pine.LNX.4.58.0502111801000.2165@ppc970.osdl.org>
References: <200502112058_MC3-1-95CC-5FF1@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Feb 2005, Chuck Ebbert wrote:
> 
>   And in any case is it too much to ask for an 80-column limit? ;)

Yes. Dammit, especially for something like this, the long-line version is 
just _so_ much more readable. Compare my and your version wrt being able 
to tell what the differences between the four different cases are.

In the single-long-line version, the differences are trivially visible. In 
the "prettified" version (aka "I'm still living in the 60's, and proud of 
it" version), it's impossible to pick out the differences.

If you don't like long lines, use a helper #define for the common part or 
something.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbUAYVwC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUAYVuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:50:08 -0500
Received: from colin2.muc.de ([193.149.48.15]:51729 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265252AbUAYVs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:48:56 -0500
Date: 25 Jan 2004 22:46:53 +0100
Date: Sun, 25 Jan 2004 22:46:53 +0100
From: Andi Kleen <ak@muc.de>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, bunk@fs.tum.de,
       eric@cisu.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125214653.GB28576@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <20040125174837.GB16962@colin2.muc.de> <20040125131153.16bb662b.akpm@osdl.org> <200401252221.01679.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401252221.01679.cova@ferrara.linux.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 10:21:01PM +0100, Fabio Coatti wrote:
> Alle Sunday 25 January 2004 22:11, Andrew Morton ha scritto:
> 
> > >
> > > I disagree with that change.
> >
> > Well there doesn't seem much doubt that -funit-at-a-time causes Fabio's
> > kernel to fail.  Do we know exactly which compiler he is using?
> 
> Well,  I'm using gcc (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk), provided 
> with Mandrake 9.2. If more details about configuration are needed please let 
> me know.

Let's take this from the start:

what kernel version are you running exactly? 
what oops are you seeing? 
does official 2.6.2rc1 (not mm) with -funit-at-a-time enabled in the Makefile
work? 

-Andi

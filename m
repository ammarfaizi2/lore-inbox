Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264975AbUELFLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbUELFLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 01:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUELFLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 01:11:40 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:10451 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264975AbUELFLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 01:11:37 -0400
Date: Tue, 11 May 2004 22:11:22 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Wim Coekaerts <wim.coekaerts@oracle.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040512051122.GA3927@taniwha.stupidest.org>
References: <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org> <20040511002426.GD1105@ca-server1.us.oracle.com> <20040510181008.1906ea8a.akpm@osdl.org> <20040511015118.GA4589@ca-server1.us.oracle.com> <20040511072329.D12187@infradead.org> <20040512024425.GV3829@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512024425.GV3829@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 04:44:25AM +0200, Andrea Arcangeli wrote:

> I'm quite confortable to say that disable_cap_mlock can be dropped
> in 2.8

Cool.

> by that time a replacement solution will be implemented and
> I don't expect any application learning about the disable_cap_mlock
> name, they really shouldn't, only the bootup procedure of the OS
> will know about it and only the login/su will learn about the future
> replacement.

Agreed.  It's hack but it's a simpler hack.

> So I believe the best "hack" is to use the simple disable_cap_mlock
> and to concentrate all the efforts on a more flexible solution
> involving userspace changes.

I quite agree here too.  I guess as things stand right now I'll take
either approach IFF it will be yanked in 2.7.x when a better
replacement is available.


  --cw

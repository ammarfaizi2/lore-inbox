Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270987AbTHQUoE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270993AbTHQUoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:44:04 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:204 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S270987AbTHQUoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:44:02 -0400
Date: Sun, 17 Aug 2003 21:42:49 +0100
From: Dave Jones <davej@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: michaelc <michaelc@turbolinux.com.cn>, linux-kernel@vger.kernel.org
Subject: Re: about PENTIUM4 cache line
Message-ID: <20030817204249.GA2225@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jamie Lokier <jamie@shareable.org>,
	michaelc <michaelc@turbolinux.com.cn>, linux-kernel@vger.kernel.org
References: <865464921.20010309170338@turbolinux.com.cn> <20030817202534.GC3543@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817202534.GC3543@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 09:25:35PM +0100, Jamie Lokier wrote:
 > michaelc wrote:
 > >      I read the Intel IA-32 developer's manual recently, and I found
 > >  the cache lines for L1 and L2 caches in Pentium4 are 64 bytes
 > >  wide, but the thing make me confused is that the default value
 > >  CONFIG_X86_L1_CACHE_SHIFT option in 2.4.x kernel is 7, why it's
 > >  not 6?   Any expanation about this would be appreciated!
 > 
 > I don't recall seeing an answer to this.
 > Was there one?

ISTR it was something to do with how the P4 cachelines are laid out.
Something like 2 sectors of 64 byte lines.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk

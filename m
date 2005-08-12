Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVHLRIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVHLRIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVHLRIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:08:07 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10943 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750706AbVHLRIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:08:06 -0400
Date: Fri, 12 Aug 2005 13:07:51 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Dave Jones <davej@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
 between /dev/kmem and /dev/mem)
In-Reply-To: <20050812165657.GC13749@redhat.com>
Message-ID: <Pine.LNX.4.58.0508121302590.26736@localhost.localdomain>
References: <1123796188.17269.127.camel@localhost.localdomain>
 <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
 <20050812165657.GC13749@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Aug 2005, Dave Jones wrote:
>
> The above patches were in -mm for a while, though they didn't
> have a config option, they just 'did it', and some of the
> changes were a bit unclean, but I can polish that up if you're
> interested.

Again, I'm asking to have it turned into a config option. Even default to
off. I understand that /dev/kmem shouldn't be in a production machine.
There's no reason for it.  But it is nice to have when debugging the
kernel.  I'll make the changes if need be, to make this into a config
option (placed in the kernel debug section).  I'll even maintain it to
keep it working.  But I don't want yet another thing I need to write
myself for debugging the kernel.

Thanks,

-- Steve


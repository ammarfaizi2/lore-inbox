Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTK2Fbc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 00:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTK2Fbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 00:31:32 -0500
Received: from holomorphy.com ([199.26.172.102]:48836 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263647AbTK2Fbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 00:31:31 -0500
Date: Fri, 28 Nov 2003 21:31:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: John Zielinski <grim@undead.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rootfs mounted from user space - problem with umount
Message-ID: <20031129053128.GF8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Zielinski <grim@undead.cc>, linux-kernel@vger.kernel.org
References: <3FC82D8F.9030100@undead.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC82D8F.9030100@undead.cc>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 12:24:31AM -0500, John Zielinski wrote:
> I modified my kernel so that rootfs uses tmpfs (shm) instead of ramfs.  
> I also modified it so that it allows mounting from user space.  My 
> problem is when I try to umount it, umount hangs.  I checked it's 
> proc/#/wchan entry and it's stuck in rwsem_down_write_failed.  Now the 
> strange thing is I can mount it again from another console and then 
> umount it with no problems.  It just hangs the first time.  I know I'm 
> missing something simple but I can't seem to find it.

Could you do a sysrq t and send in a backtrace?


-- wli

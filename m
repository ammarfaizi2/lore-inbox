Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTEOBLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTEOBLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:11:18 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:54721 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263436AbTEOBLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:11:15 -0400
Date: Wed, 14 May 2003 18:25:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: ch@murgatroid.com, inaky.perez-gonzalez@intel.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-Id: <20030514182526.36823e2b.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0305141758070.28007-100000@home.transmeta.com>
References: <001c01c31a7c$327cc350$175e040f@bergamot>
	<Pine.LNX.4.44.0305141758070.28007-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 01:23:59.0753 (UTC) FILETIME=[A9730790:01C31A80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> And do you guys actually use a recent glibc snapshot? Do you ever expect 
>  to?

I believe this effort is more targetted at teeny little embedded gadgets -
devices which are very remote from workstations, desktops and servers.

Presumably the people who are programming such gadgets will know if they
need futexes or not.


We've never clearly addressed the issue of just how far the mainstream
kernel should scale down, and how pluggable the various kernel components
should be.

Retrofitting pluggability is hard (CONFIG_BLOCK_LAYER) but at the very
least, we should make this effort for newly-added components.


Assuming, of course, that we _do_ want to make the mainstream kernel scale
that far down.  It could be argued that this is a role for vendors or other
specialised parties.


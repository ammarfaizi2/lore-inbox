Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTF0Lpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTF0Lpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:45:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54107 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264248AbTF0Lpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:45:42 -0400
Date: Fri, 27 Jun 2003 11:59:34 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Brown, Len" <len.brown@intel.com>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] acpismp=force fix
Message-ID: <20030627115934.D16156@devserv.devel.redhat.com>
References: <A5974D8E5F98D511BB910002A50A66470B981205@hdsmsx103.hd.intel.com> <Pine.LNX.4.44.0306271221110.1197-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0306271221110.1197-100000@localhost.localdomain>; from hugh@veritas.com on Fri, Jun 27, 2003 at 12:58:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 12:58:17PM +0100, Hugh Dickins wrote:
> and in 2.4.22-pre (which thus diverges from 2.4.21).  That surprises me,
> but I'd definitely defer to Arjan's preference.

for 2.4 it's a matter of compatability; also Andrew said it made the
code cleaner actually.

> > Re: "acpismp=force"
> > I wouldn't miss it.  Sounds unanimous.
> 
> It did have some point before, recent changes have rendered it pointless,
> and even if those changes get revised, there'll be a better way than the
> confusing "acpismp=force".

it became mostly useless when the automatic detection based on CPU flag went it

> > Re: "noht"
> > To disable HT on a uni-processor, wouldn't it be preferable to simply run
> > the UP kernel rather than the SMP kernel with HT disabled?
> 
> Yes, though wouldn't BIOS be able to disable it on those too?

not all bioses have such a setting unfortionatly so it remains a
useful option.


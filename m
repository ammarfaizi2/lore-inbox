Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbTFWLkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbTFWLkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:40:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:18163 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265115AbTFWLkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:40:21 -0400
Date: Mon, 23 Jun 2003 11:54:08 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@digeo.com>,
       torvalds@transmeta.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] acpismp=force fix
Message-ID: <20030623115408.E23874@devserv.devel.redhat.com>
References: <1056355301.1699.6.camel@laptop.fenrus.com> <Pine.LNX.4.44.0306231224590.1648-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0306231224590.1648-100000@localhost.localdomain>; from hugh@veritas.com on Mon, Jun 23, 2003 at 12:46:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 12:46:38PM +0100, Hugh Dickins wrote:
> Certainly reliance on "acpismp=force" should be removed if it's crept
> back in.  But what should we do about "noht"?  Wave a fond goodbye,
> and remove it's associated code and Documentation from 2.4 and 2.5
> trees, rely on changing the BIOS setting instead?  Or bring it back
> into action?

for 2.4 it's no problem to honor it really code wise; and it's
useful for machines where you can't disable HT in the bios but where
your particular workload doesn't positively benefit from HT.

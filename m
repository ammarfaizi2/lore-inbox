Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261569AbSKGUSI>; Thu, 7 Nov 2002 15:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbSKGUSI>; Thu, 7 Nov 2002 15:18:08 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:61710 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261569AbSKGUSH>; Thu, 7 Nov 2002 15:18:07 -0500
Date: Thu, 7 Nov 2002 20:24:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kevin Corry <corryk@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, evms-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: EVMS announcement
Message-ID: <20021107202438.A7960@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kevin Corry <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
	evms-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <02110516191004.07074@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02110516191004.07074@boiler>; from corryk@us.ibm.com on Tue, Nov 05, 2002 at 04:19:10PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 04:19:10PM -0600, Kevin Corry wrote:
> Greetings EVMS users,
> 
> On behalf of the EVMS team, we would like to announce a significant change
> in direction for the Enterprise Volume Management System project.
> 
> As many of you may know by now, the 2.5 kernel feature freeze has come
> and gone, and it seems clear that the EVMS kernel driver is not going
> to be included. With this in mind, we have decided to rework the EVMS
> user-space administration tools (the Engine) to work with existing
> drivers currently in the kernel, including (but not necessarily limited
> to) device mapper and MD.

Hi Kevin,

I think that's a very good move for EVMS in the long term.  You will
be able to provide the users what they want (an easy to user and
integrated volume managment solution) without having the pain of
maintaining a large base of kernel-level code.

Of course there will be some hassle for you now, like adding DM plugins
for higher raid levels, etc..  But in the end I guess it will hope both
EVMS and Linux.  EVMS by reducing the scope of the project without
reducing it's functionality, the Linux by having a modular and leight-weight
in kernel volume-managment solution with many eyes looking at it, using
it and improving it.  I guess you will find a bunch of suboptimal things
in DM very soon and I hope you will help the kernel community in fixing
it.  This of course means also that DM will hopefully get an integral part
of the kernel, not an Sistina Project like LVM1.

I (and I guess many other kernel developers interested in storage
handling) will look forward to the comments who the current kernel-level
storage managment facilities are useable by an unified userland engine
handling it, and I guess mthere will be many obvious improvement.

I'm also looking forward to IBM's opensource cluster volumemanagment
integration as competitions to Sistina's propritary addons.

I wish you all luck with your new direction and expect me and other kernel
developers in that area to help you wherever we can.

	Christoph


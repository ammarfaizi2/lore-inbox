Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbTEBVMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbTEBVMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 17:12:41 -0400
Received: from ns.suse.de ([213.95.15.193]:51210 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263124AbTEBVMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 17:12:40 -0400
Date: Fri, 2 May 2003 23:25:05 +0200
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Message-ID: <20030502212505.GD21239@oldwotan.suse.de>
References: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com.suse.lists.linux.kernel> <200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk.suse.lists.linux.kernel> <b8udjm$cgq$1@cesium.transmeta.com.suse.lists.linux.kernel> <p73n0i5138g.fsf@oldwotan.suse.de> <3EB2DB8C.70600@zytor.com> <20030502210758.GB21239@oldwotan.suse.de> <3EB2DEA2.6070002@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB2DEA2.6070002@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 02:09:54PM -0700, H. Peter Anvin wrote:
> Andi Kleen wrote:
> >>
> >>Why is that?  And, in particular, why is it "too late to turn it back
> > 
> > mprotect() didn't (and probably still does not) work when you change
> > PROT_EXEC.
> >
> 
> Kernel bug or CPU bug?

Kernel bug probably. Need to debug it sometime, but there were more important
things to do. Of course patches would be welcome if anybody is motivated ;)

-Andi

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272449AbRIVWjU>; Sat, 22 Sep 2001 18:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272464AbRIVWjL>; Sat, 22 Sep 2001 18:39:11 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:615 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S272449AbRIVWjF>; Sat, 22 Sep 2001 18:39:05 -0400
Date: Sat, 22 Sep 2001 18:39:30 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre13aa1
Message-ID: <20010922183930.C19881@redhat.com>
In-Reply-To: <20010921095721.A725@athlon.random> <20010921131841.A15773@redhat.com> <20010922092859.N11674@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010922092859.N11674@athlon.random>; from andrea@suse.de on Sat, Sep 22, 2001 at 09:28:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 09:28:59AM +0200, Andrea Arcangeli wrote:
> On Fri, Sep 21, 2001 at 01:18:41PM -0400, Benjamin LaHaise wrote:
> > the page.  If people are truely paranoid, then make it a boot time assertion.
> 
> What do you think if I replace the mkdirty with a BUG() in case the pte
> gets marked dirty? Just to be sure no hardware gets it wrong.

Sure.  At some point it should be made part of debugging-only builds.  Cheers,

		-ben

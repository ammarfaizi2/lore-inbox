Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263761AbRFLXS0>; Tue, 12 Jun 2001 19:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263814AbRFLXSQ>; Tue, 12 Jun 2001 19:18:16 -0400
Received: from [203.36.158.121] ([203.36.158.121]:2056 "EHLO
	piro.kabuki.sfarc.net") by vger.kernel.org with ESMTP
	id <S263761AbRFLXSH>; Tue, 12 Jun 2001 19:18:07 -0400
Date: Wed, 13 Jun 2001 09:15:06 +1000
From: Daniel Stone <daniel@kabuki.sfarc.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: Daniel Stone <daniel@kabuki.sfarc.net>,
        Daniel Podlejski <underley@underley.eu.org>,
        linux-kernel@vger.kernel.org
Subject: Re: XFS and Alan kernel tree
Message-ID: <20010613091505.A3989@kabuki.openfridge.net>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Daniel Stone <daniel@kabuki.sfarc.net>,
	Daniel Podlejski <underley@underley.eu.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <13436.992386996@ocs4.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13436.992386996@ocs4.ocs-net>
User-Agent: Mutt/1.3.18i
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2001 at 09:03:16AM +1000, Keith Owens wrote:
> On Wed, 13 Jun 2001 08:25:52 +1000, 
> Daniel Stone <daniel@kabuki.sfarc.net> wrote:
> >On Sat, May 05, 2001 at 11:08:16PM +0200, Daniel Podlejski wrote:
> >> I merge XFS witch Alan tree (2.4.4-ac5). It's seems to be stable.
> >> Patch against Alan tree is avaliable at:
> >
> >Hi Daniel,
> >I've got a KDB patch against a relatively recent 2.4.5-ac6, but are you
> >still continuing your porting effort to the -ac series?
> 
> kdb v1.8-2.4.5-ac6 works for -ac6 through -ac13.  None of the changes
> in that series affect kdb.
> 
> There have been some significant changes to page I/O handling in
> 2.4.6-pre[12] which are reflected in the XFS CVS tree.  -ac13 is still
> using the old page_launder() code which is not as clean.  In addition
> kdb for Linus's and AC's trees has diverged quite a bit because of the
> console and NMI cleanup in -ac.  Fitting XFS from CVS into -ac13 will
> be very nasty, you might want to wait until AC syncs to Linus's kernel
> or Linus takes some of the -ac changes.

Hmm, I've got Rik's page_launder patch which was posted to lkml a couple of
days ago, and hand-hacked that into ac. I got the CVS tree and manually
hacked out 2.4.6-pre2, but with 22 different files with rejects when I tried
to put -ac in, I just gave up.

d 

-- 
Daniel Stone		<daniel@kabuki.openfridge.net> <daniel@kabuki.sfarc.net>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWJCM4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWJCM4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWJCM4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:56:42 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:40457 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932124AbWJCM4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:56:41 -0400
Date: Tue, 3 Oct 2006 08:49:07 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Dan Williams <dcbw@redhat.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Theodore Tso <tytso@mit.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       jt@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003124902.GB23912@tuxdriver.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org> <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com> <1159877574.2879.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159877574.2879.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 08:12:53AM -0400, Dan Williams wrote:
> On Tue, 2006-10-03 at 00:08 +0200, Alessandro Suardi wrote:
> > On 10/2/06, Theodore Tso <tytso@mit.edu> wrote:
> > > On Mon, Oct 02, 2006 at 05:00:31PM -0400, Dan Williams wrote:
> > > > Distributions _are_ shipping those tools already.  The problem is more
> > > > with older distributions where, for example, the kernel gets upgraded
> > > > but other stuff does not.  If a kernel upgrade happens, then the distro
> > > > needs to make sure userspace works with it.  That's nothing new.
> > >
> > > Um, *which* distro's are shipping it already?  RHEL4?  SLES10?  I
> > > thought we saw a note saying that even Debian **unstable** didn't have
> > > a new enough version of the wireless-tools....
> > 
> > That was my point initially. FC5-latest is apparently carrying
> >  tools which are "too old"... and I yum update twice or thrice
> >  a week. Not that *I* minded building packages from source,
> >  but this is likely a bit too much for a good slice of the userbase.
> 
> And that's my fault.  I was made aware of this issue last week and am
> currently testing out the newer wireless-tools with the intention of
> pushing them to FC5-updates.  Had I actually been tracking the
> wireless-tools release cycle more closely, I would have pushed the
> wireless-tools-28 final version when it came out.
> 
> But, as far as I know (please correct me if I'm wrong), that 2.6.18
> doesn't actually include WE-21! [1]  Somebody is trying to run
> out-of-kernel ipw3945 drivers using a 2.6.18 kernel from FC5 that's
> WE-20 only, but the driver uses WE-21?

Obviously I was a bit optimisitic in accepting the notion that distros
had already upgraded their userland bits to handle WE-21.  I apologize.

As Dan points-out, it will be a while before distros (other than
Fedora rawhide and equivalents) have 2.6.19 kernels for general
users.  For now, those experiencing this issue should be comfortable
experiencing some breakage...?

So, is the window between now and the release of 2.6.19 big enough
to give the distros time to get wireless-tools and wpa_supplicant
into their update streams?  Or do we need to go through the pain of
reverting/delaying WE-21?

John
-- 
John W. Linville
linville@tuxdriver.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268380AbTAMWnh>; Mon, 13 Jan 2003 17:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268382AbTAMWnh>; Mon, 13 Jan 2003 17:43:37 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:59405 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S268380AbTAMWne>; Mon, 13 Jan 2003 17:43:34 -0500
Date: Mon, 13 Jan 2003 14:52:17 -0800
From: jw schultz <jw@pegasys.ws>
To: "Richard B. Tilley  (Brad)" <rtilley@vt.edu>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bugs and Releases Numbers
Message-ID: <20030113225217.GC17075@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	"Richard B. Tilley  (Brad)" <rtilley@vt.edu>,
	Adrian Bunk <bunk@fs.tum.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1042469616.28005.36.camel@oubop4.bursar.vt.edu> <20030113150708.GI21826@fs.tum.de> <1042471046.28000.42.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042471046.28000.42.camel@oubop4.bursar.vt.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 10:17:22AM -0500, Richard B. Tilley  (Brad) wrote:
> So, if a major security bug was discovered in stable that impacted many
> systems in a very fundamental way, then a patch would be written and
> applied right away and a new kernel would be released, no?

No.  A new kernel need not be released right away.  Patches
would be made available for affected recent releases.
Anyone running self-built downloaded kernels is expected to
be able to patch them when needed.  Distributions would
apply the patch to their trees and make the new kernel
(source and binaries) available through their usual security
update channels.

It simply isn't necessary to rush a release (contrary to the
principles of stable) just because there is a security hole.
Patches are sufficient.  Besides, most sites run the
distribution kernels anyway so they will get the fix through
those channels.


> If that ever happened, what would become of the patches that had been in
> pre? Would they be included in the new kernel too, or not?
> 
> On Mon, 2003-01-13 at 10:07, Adrian Bunk wrote:
> > On Mon, Jan 13, 2003 at 09:53:36AM -0500, Richard B. Tilley  (Brad) wrote:
> > 
> > > Hello,
> > 
> > Hi Richard,
> > 
> > > How are bug patches worked into the current stable release? For example,
> > > the ext3 file corruption bug in 2.4.20, was that patch worked into the
> > > kernel or will it be included in 2.4.21? I'm confused about the exact
> > > details of this type of thing. If the patch was worked in to 2.4.20, how
> > > can one tell as the release number doesn't/hasn't changed?
> > >...
> > 
> > the kernel that was released as 2.4.20 will never be changed.
> > 
> > The ext3 problems are fixed in the 2.4.21-pre kernels and the fixed ext3 
> > code will be in 2.4.21.
> > 
> > > Thank you,
> > > 
> > > Brad
> > 
> > cu
> > Adrian
> > 
> > -- 
> > 
> >        "Is there not promise of rain?" Ling Tan asked suddenly out
> >         of the darkness. There had been need of rain for many days.
> >        "Only a promise," Lao Er said.
> >                                        Pearl S. Buck - Dragon Seed
> > 
> -- 
> Richard B. Tilley (Brad), System Administrator & Web Developer
> Virginia Tech, Office of the University Bursar
> Phone: 540.231.6277
> Fax: 540.231.3238
> Page: 557.0891
> Web: http://www.bursar.vt.edu
> GPG Key: http://www.bursar.vt.edu/rtilley/pgpkey



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

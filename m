Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319416AbSILCoU>; Wed, 11 Sep 2002 22:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319417AbSILCoU>; Wed, 11 Sep 2002 22:44:20 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:28940 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S319416AbSILCoT>; Wed, 11 Sep 2002 22:44:19 -0400
Date: Wed, 11 Sep 2002 19:48:39 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS?
Message-ID: <20020912024839.GG10315@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <p73wupuq34l.fsf@oldwotan.suse.de> <200209101518.31538.nleroy@cs.wisc.edu> <20020911084327.GF6085@pegasys.ws> <200209110820.36925.nleroy@cs.wisc.edu> <20020911212146.GC10315@pegasys.ws> <20020911230138.GA29574@hq.alert.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911230138.GA29574@hq.alert.sk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 01:01:38AM +0200, Robert Varga wrote:
> On Wed, Sep 11, 2002 at 02:21:46PM -0700, jw schultz wrote:
> > On Wed, Sep 11, 2002 at 08:20:36AM -0700, Nick LeRoy wrote:
> > > On Wednesday 11 September 2002 01:43, jw schultz wrote:
> > > I think this is a wonderful feature, albeit potentially confusing to a Newbie   
> > > For my O2 running IRIX I get XFS whether I like it or not, for Solaris I get 
> > > UFS no matter how much it sucks (I'm not really saying that it does; I don't 
> > > have much knowledge of it to be honest).  This multitude of choices really 
> > > causes competition between them, and makes them all better in the long run.
> > 
> > On Solaris and some other platforms you can, with lots of
> > money, buy a license to run the Veritas journaling
> > filesystem.  It comes with a license manager and you have to
> > get license keys to mount the filesystems.  Ever had a
> > filesystem not come up after a reboot because the license
> > expired, i have (ouch, i told management to renew the
> > license).  Is veritas fast? I don't know.  They hype the
> > journaling, not speed.  And what are you going to benchmark
> > against?.
> 
> Against UFS, of course [1] :-) Their hype is "our journal is faster than
> UFS", which is probably true. They have extent-based allocation,

Comparing Veritas FS against UFS is like comparing apples
and steak.  Their goals are so diffent it is rediculous.

My comment is that with no apples-apples comparisons (or at
least apples-pears) who knows how good it is.

> which is good for their greatest hype - performance with databases
> (see all the marketing shredder-food about [Cached] QuickIO).
> They have hot resizing, which fast as hell (again, compared to UFS),
> they have snapshots, which are cool. And don't forget the GFS capability,
> which I am yet to see in action. [2]
> 
> So in Solaris world, for large filesystems, Veritas is the winner. I am
> really looking forward to seeing how will they do in the OpenSource
> world.

Don't get me wrong, feature-wise Veritas FS is a great
product.  Their hot resizing (including shrink) is a
must-have feature.  I never had a lick of problems with it
despite flaky GbIX (Gibabit FCAL Interface transceivers).

> [1] Actually they benchmark Oracle on raw devices vs. Cached QuickIO, too.
> [2] Even tough the options are expensive, in my experience all of them
> work perfectly.



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319342AbSIKVRI>; Wed, 11 Sep 2002 17:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319343AbSIKVRI>; Wed, 11 Sep 2002 17:17:08 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:13580 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S319342AbSIKVRF>; Wed, 11 Sep 2002 17:17:05 -0400
Date: Wed, 11 Sep 2002 14:21:46 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS?
Message-ID: <20020911212146.GC10315@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <p73wupuq34l.fsf@oldwotan.suse.de> <200209101518.31538.nleroy@cs.wisc.edu> <20020911084327.GF6085@pegasys.ws> <200209110820.36925.nleroy@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209110820.36925.nleroy@cs.wisc.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 08:20:36AM -0700, Nick LeRoy wrote:
> On Wednesday 11 September 2002 01:43, jw schultz wrote:
> 
> > And think about this:  In almost all other OSs of substance
> > you have one or two basic filesystem types and if you want
> > journaling you have to pay extra for it.  And journaling
> > filesystems don't have to be fast, there is very little real
> > competition.
> 
> I'm not sure if you're saying that this is a bad thing or a good thing.  FWIW, 

Unless you like tyrany choice is a good thing(TM).  Trust
me, i don't like tyrany.

> I think this is a wonderful feature, albeit potentially confusing to a Newbie   
> For my O2 running IRIX I get XFS whether I like it or not, for Solaris I get 
> UFS no matter how much it sucks (I'm not really saying that it does; I don't 
> have much knowledge of it to be honest).  This multitude of choices really 
> causes competition between them, and makes them all better in the long run.

On Solaris and some other platforms you can, with lots of
money, buy a license to run the Veritas journaling
filesystem.  It comes with a license manager and you have to
get license keys to mount the filesystems.  Ever had a
filesystem not come up after a reboot because the license
expired, i have (ouch, i told management to renew the
license).  Is veritas fast? I don't know.  They hype the
journaling, not speed.  And what are you going to benchmark
against?.

Recently Veritas announced they were going to support Linux.
I'm curious to see how they fare in a shootout with the
other journaling filesystems.  Of course i wouldn't taint MY
kernel to run it when i have four others to choose from.

> Think about this:  Namesys is working on Reiserfs v4.0.  v4.0.  Hell - it's 
> only been incorporated into the mainstream kernel for less than a year (at 
> least by my recollection), yet it keeps advancing.  I have _no_ idea what UFS 
> version Solaris 8 is using (admittedly at least somewhat due to ignorance -- 
> I use Solaris because I have a good ol' SPARCprinter which alas is not 
> supported by Linux), or whether they've bother to do development on it to 
> make it better, faster, etc.  Yet, _we_ get this advancement all the time.  
> Isn't it great?!

Fantastic.  And that is largly without competition.  Just
wait and watch what the JFS and XFS developers do to improve
their products to keep up.

As for UFS, the only thing they can do to it is to adjust
the block allocation heuristics.  Something i'm sure they
have done to death for the TPC benchmarks they live and die
by.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318541AbSIKIix>; Wed, 11 Sep 2002 04:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318542AbSIKIix>; Wed, 11 Sep 2002 04:38:53 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:28939 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318541AbSIKIis>; Wed, 11 Sep 2002 04:38:48 -0400
Date: Wed, 11 Sep 2002 01:43:27 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS?
Message-ID: <20020911084327.GF6085@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <p73wupuq34l.fsf@oldwotan.suse.de> <20020910142347.A5000@q.mn.rr.com> <92ksnuc403ubdr07dqvnor1mf9lr18srij@4ax.com> <200209101518.31538.nleroy@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209101518.31538.nleroy@cs.wisc.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 03:18:31PM -0700, Nick LeRoy wrote:
> > So does Redhat/Suse/??? ship XFS yet?
> 
> Don't know about RedHat & others, but SuSE _does_ ship XFS.
> 

Yes it does.  I'm guessing the one in 8.0 is an older
version because i found it performs abysmally.  It seemed
stable enough but i used it for backups with lots of file
creation and deletion and my jobs took about 10 times longer
to run than on ext2 or JFS (also included in the 2.4.18+
SuSE 8.0)  For other use it is probably fine.  I look
forward to trying newer versions.

While i'm talking about it online resize including shrinkage
is a fairly high priority for me.  Any journaling filesystem
without that feature is going to be a second-rater.  So
without it XFS is unlikely to become a primary filesystme
choice for me.  That said, i'm glad to see variety in the
journaling filesystems and look forward to XFS getting in
mainline so we can use whatever filesystem that best meets
our needs.  This of course means that we will need decent,
independent, comparisons of the filesystems.

And think about this:  In almost all other OSs of substance
you have one or two basic filesystem types and if you want
journaling you have to pay extra for it.  And journaling
filesystems don't have to be fast, there is very little real
competition.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

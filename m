Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287865AbSAUSrm>; Mon, 21 Jan 2002 13:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287816AbSAUSrc>; Mon, 21 Jan 2002 13:47:32 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:45605 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S287865AbSAUSrU>; Mon, 21 Jan 2002 13:47:20 -0500
Date: Mon, 21 Jan 2002 18:46:53 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler updates, -J2
Message-ID: <20020121184652.A1289@sackman.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201181710520.10122-100000@localhost.localdomain> <20020119221928.A2042@sackman.co.uk> <20020120230102.A7373@sackman.co.uk> <20020121010231.A15740@sarah.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20020121010231.A15740@sarah.kolej.mff.cuni.cz>; from martin.macok@underground.cz on Mon, Jan 21, 2002 at 01:02:31AM +0100
From: matthew@sackman.co.uk (Matthew Sackman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 01:02:31AM +0100, Martin Ma?ok wrote:
> On Sun, Jan 20, 2002 at 11:01:04PM +0000, Matthew Sackman wrote:
> > > >     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-J2.patch
> > 
> > One other thing that I've noticed, switching virtual workspaces will
> > reliably cause xmms to stutter. If you switch rapidly then it is
> > exacerbated.
> 
> And without sched O(1) it isn't ?
> 
> This doesn't have to be the scheduler problem, but a problem somewhere
> else (low latency (?)).
> 
> For me it doesn't skip even under heavy disk (IDE), VM and cpu load
> while while switching 1280x1024 workspaces really fast and for a long
> time
> [Athlon 850, Matrox G450, XF4.1, Window Maker]
> 
> (I use it with rmap11c + mini-ll + ah-IDE ... = -jl-11-mini + 18pre3)

I've never had it without. The files xmms is playing is on an NFS mount.
Previously I've only used 2.4.x kernels with no patches. The O(1) J2 is
the only patch I've got applied. (PIII 500, 192MB, XF4.1, uwm, 100BaseTX,
NFS 3, X running with Xinerama on dual head - any more details?)

Matthew

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268060AbTBWH6x>; Sun, 23 Feb 2003 02:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTBWH6x>; Sun, 23 Feb 2003 02:58:53 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:44673 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S268060AbTBWH6v>; Sun, 23 Feb 2003 02:58:51 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Date: Sun, 23 Feb 2003 00:07:50 -0800 (PST)
Subject: Re: Minutes from Feb 21 LSE Call 
In-Reply-To: <E18moa2-0005cP-00@w-gerrit2>
Message-ID: <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Gerrit Huizenga wrote:

> On Sat, 22 Feb 2003 20:17:24 EST, Benjamin LaHaise wrote:
> > On Sat, Feb 22, 2003 at 02:18:20PM -0800, William Lee Irwin III wrote:
> > > I'm not sure what's so nice about x86-64; another opcode prefix
> > > controlled extension atop the festering pile of existing x86 crud
> >
> > What's nice about x86-64 is that it runs existing 32 bit apps fast and
> > doesn't suffer from the blisteringly small caches that were part of your
> > rant.  Plus, x86-64 binaries are not horrifically bloated like ia64.
> > Not to mention that the amount of reengineering in compilers like
> > gcc required to get decent performance out of it is actually sane.
>
> Four or five years ago the claim was that IA64 would solve all the large
> memory problems.  Commercial viability and substantial market presence
> is still lacking.  x86-64 has the same uphill battle.  It has a better
> architecture for highmem and potentially better architecture for large
> systems in general (compared to IA32, not substantially better than, say,
> IA64 or PPC64).  It also has at least one manufacturer looking at high
> end systems.  But until those systems have some recognized market share,
> the boys with the big pockets aren't likely to make the ubiquitous.
> The whole thing about expenses to design and develop combined with the
> ROI model have more influence on their deployment than the fact that it
> is technically a useful architecture.

Garrit, you missed the preior posters point. IA64 had the same fundamental
problem as the Alpha, PPC, and Sparc processors, it doesn't run x86
binaries.

the 8086/8088 CPU was nothing special when it was picked to be used on the
IBM PC, but once it was picked it hit a critical mass that has meant that
compatability with it is critical to a new CPU. the 286 and 386 CPUs were
arguably inferior to other options available at the time, but they had one
feature that absolutly trumped everything else, they could run existing
programs with no modifications faster then anything else available. with
the IA64 Intel forgot this (or decided their name value was so high that
they were immune to the issue) x86-64 takes the same approach that the 286
and 386 did and will be used by people who couldn't care less about 64 bit
stuff simply becouse it looks to be the fastest x86 cpu available (and if
the SMP features work as advertised it will again give a big boost to the
price/performance of SMP machines due to much cheaper MLB designs). if it
was being marketed by Intel it would be a shoo-in, but AMD does have a bit
of an uphill struggle

David Lang

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276350AbRI1WdE>; Fri, 28 Sep 2001 18:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276353AbRI1Wcy>; Fri, 28 Sep 2001 18:32:54 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23799
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S276324AbRI1Wck>; Fri, 28 Sep 2001 18:32:40 -0400
Date: Fri, 28 Sep 2001 15:33:01 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Tools better than vmstat [was: 2.4.9-ac16 good perfomer?]
Message-ID: <20010928153301.A23261@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200109281826.f8SIQLP06585@deathstar.prodigy.com> <Pine.LNX.4.33L.0109281535220.26495-100000@duckman.distro.conectiva> <20010928123455.B8222@mikef-linux.matchmail.com> <20010928210453.B15457@flint.arm.linux.org.uk> <20010928145324.A14801@mikef-linux.matchmail.com> <20010928230034.F15457@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010928230034.F15457@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 11:00:34PM +0100, Russell King wrote:
> On Fri, Sep 28, 2001 at 02:53:24PM -0700, Mike Fedyk wrote:
> > Is there any possibility of using Russell's patch for this user space tool?
> 
> There is one property the kernel space method has over any user space
> tool on a UP machine (and conceivably a SMP machine with more code) -
> you get a complete atomic snapshot of the VM state.  Might be useful
> and important, but might not be.
>

Actually, I was suggesting a combined kernel and user space design.

/proc/vm-page-ages would give all of the gory numbers in an atomic way, and
vm-page-stat would distil that into the percentages much like vmstat
output...

> It would be pretty easy to change my kernel patch to produce what you're
> requesting, from another sysrq key combination.
> 

Is sysrq easier to code for, or initiate-on-proc-read?

I'm just sorry I don't know enough C to do this myself... :(

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290972AbSAaG2Y>; Thu, 31 Jan 2002 01:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290971AbSAaG2E>; Thu, 31 Jan 2002 01:28:04 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:1255 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290970AbSAaG15>;
	Thu, 31 Jan 2002 01:27:57 -0500
Date: Thu, 31 Jan 2002 01:27:55 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Rob Landley <landley@trommello.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131012755.A31861@havoc.gtf.org>
In-Reply-To: <200201302239.QAA39272@tomcat.admin.navo.hpc.mil> <20020131032832.KJVO14927.femail22.sdc1.sfba.home.com@there> <E16W85P-0000Kc-00@starship.berlin> <20020131053131.NGIN1833.femail28.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131053131.NGIN1833.femail28.sdc1.sfba.home.com@there>; from landley@trommello.org on Thu, Jan 31, 2002 at 12:32:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 12:32:40AM -0500, Rob Landley wrote:
> On Wednesday 30 January 2002 10:40 pm, Daniel Phillips wrote:
> > > I expect it will all get worked out eventually.  Now that the secret of
> > > the difference between maintainers and lieutenants is out.

> > By the way, that never was a secret to anybody in active development.
> 
> I.E. the people who knew it knew it, and hence never noticed the problem...
> 
> There are, however, some people writing largeish bits of code that did not in 
> fact seem to know it.  Andre Hedrick's IDE work, Eric Raymond with the help 
> files and CML2, Kieth Owens' new build process...

ESR was told things repeatedly and they didn't sink in.
(And I note you have been told this repeatedly, too.)
Did you miss Alan's comment as well?  Apparently so...
http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.3/1567.html

Andre knows his shit ten ways to Sunday, but one must speak ATA
not English with him.  Definite communications problem, despite the
fact that he writes solid low level driver code and tests it pretty
thoroughly.  It was clear at the beginning of 2.5.x that Jens' bio
stuff was going in and Andre's stuff would conflict with it.  Didn't
make Andre happy, but it was a good decision.  And now Andre's basic
taskfile stuff has been merged, so life is good.  I'm looking forward
to all the doors that taskfile has opened to the Linux kernel.

I dunno how Keith became one of your examples.  Maybe I missed it,
but I have not seen an announcement and review proving that kbuild
was ready for merging into 2.5.x.  With all due respect to the kbuild
list, I have seen a couple times "...but this was discussed and decided
upon on the kbuild list" and it turns to be an issue that definitely
requires further discussion and thought.

There is no secret.  Only willful ignorance.

If people writing largish pieces of code in isolation and expect them to
be applied without being cognizent of other development and feedback, I
-expect- their work to be dropped.  That is an example of a WORKING not
broken system.

The Linux kernel way is really evolution not revolution.

	Jeff



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261982AbREST2g>; Sat, 19 May 2001 15:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261985AbREST20>; Sat, 19 May 2001 15:28:26 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:30726
	"HELO marcus.pants.nu") by vger.kernel.org with SMTP
	id <S261980AbREST2Q>; Sat, 19 May 2001 15:28:16 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code inuserspace
To: aaronl@vitelus.com (Aaron Lehmann)
Date: Sat, 19 May 2001 12:50:10 -0700 (PDT)
Cc: Andries.Brouwer@cwi.nl, andrewm@uow.edu.au, bcrl@redhat.com,
        clausen@gnu.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        viro@math.psu.edu
In-Reply-To: <20010519110720.D2648@vitelus.com> from "Aaron Lehmann" at May 19, 2001 11:07:20 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010519195010.4C11A2B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> On Sat, May 19, 2001 at 08:05:02PM +0200, Andries.Brouwer@cwi.nl wrote:
> > > initrd is an unnecessary pain in the ass for most people.
> > > It had better not become mandatory.
> > 
> > You would not notice the difference, only your kernel would be
> > a bit smaller and the RRPART ioctl disappears.
> 
> Would I not notice the difference as a user, as a sysadmin, as a
> kernel builder, as a kernel hacker, or all of the above?

If I understand the status of stuff correctly, I think this would make it
a lot more painful to admin if it became a requirement to use initrd on
everything just to be able to boot. If you've ever seen the way some of
the bootloaders for alterate platforms (like ppc and 68k) handle booting,
you'd see what a pain it can be to have anything more than a simple string
of options getting passed to the kernel. It's particularly bad on some
of the embedded ppc platforms. I suspect that if this happened, it would
never be allowed into many people's trees, because it would be worth their
effort to maintain different code so they don't have to squeeze an initrd
on flash along with their kernel and root filesystem. If I'm missing the
boat here, please tell me, but it sure seems like a bad idea to me.

	Brad Boyer


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263083AbTCWPrE>; Sun, 23 Mar 2003 10:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263087AbTCWPrD>; Sun, 23 Mar 2003 10:47:03 -0500
Received: from pasky.ji.cz ([62.44.12.54]:28154 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S263083AbTCWPrC>;
	Sun, 23 Mar 2003 10:47:02 -0500
Date: Sun, 23 Mar 2003 16:58:05 +0100
From: Petr Baudis <pasky@ucw.cz>
To: marcelo@connectiva.com.br, Jeff Garzik <jgarzik@pobox.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030323155805.GL3475@pasky.ji.cz>
Mail-Followup-To: marcelo@connectiva.com.br,
	Jeff Garzik <jgarzik@pobox.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Pavel Machek <pavel@ucw.cz>, szepe@pinerecords.com,
	arjanv@redhat.com, alan@redhat.com, linux-kernel@vger.kernel.org
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com> <1047923841.1600.3.camel@laptop.fenrus.com> <20030317182040.GA2145@louise.pinerecords.com> <20030317182709.GA27116@gtf.org> <20030321211708.GC12211@zaurus.ucw.cz> <20030323110052.5267cba8.skraw@ithnet.com> <3E7DB99B.5050509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7DB99B.5050509@pobox.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Mar 23, 2003 at 02:41:47PM CET, I got a letter,
where Jeff Garzik <jgarzik@pobox.com> told me, that...
> Stephan von Krawczynski wrote:
> >On Fri, 21 Mar 2003 22:17:08 +0100
> >Pavel Machek <pavel@ucw.cz> wrote:
> >
> >
> >>Hi!
> >>
> >>
> >>>>Would it make sense to repackage 2.4.20 into something like 2.4.20-p1
> >>>>or 2.4.20.1 with only the critical stuff applied?
> >>>
> >>>There shouldn't be a huge need to rush 2.4.21 as-is, really.  If you
> >>>want an immediate update, get the fix from your vendor.
> >
> >
> >Sorry Jeff,
> >
> >this comment must obviously be flagged with a big community-buh. It is very
> >likely that most readers of LKML read/write here _not_ because they are
> >looking for a _vendor_ specific thing, but because they feel to a certain
> >extent as part of a linux-community and (partly) want to give something 
> >back
> >for the good things they got from it.
> >It is no hot news over here that linux does _not_ live because of 5 
> >different
> >(or more?) "vendor"-kernels, but solely because there is _the_ official
> >kernel.org kernel (releases). 
> [...]
> >So IMHO: if there is a-known-to-work patch for the discussed exploit it 
> >should
> >be released as _some_ (pre-)release for 2.4 quickly, and thanks must go to 
> >alan
> >for taking quick approach on 2.2.
> 
> 
> I think you misunderstand my point:  there was a patch posted which 
> fixes the ptrace issue.  If you want to fix your kernel, there are two 
> options:  either you are capable enough apply that patch yourself, 
> otherwise get a kernel update from a vendor.  Marcelo is under no 
> obligation to provide hot-fix kernels...

Just out of curiosity, Marcelo, when could we see 2.4.21-rc1 ? What is yet
expected to go in before rc, and how long it could take to have 2.4.21 final
out given that no other critical bugs would be discovered?

The release cycle is probably getting indeed kind of ... long; that could be ok
for ie. 2.2, but it would be nice to have shorter development cycle for the
pair of latest two development lines. Sure that the larger changes need to get
enough of testing, but then we could maybe spend the months rather between the
-rc releases than both -pre and -rc releases...?

Thanks in advance,

-- 
 
				Petr "Pasky" Baudis
.
The pure and simple truth is rarely pure and never simple.
		-- Oscar Wilde
.
Stuff: http://pasky.ji.cz/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290496AbSA3Tmg>; Wed, 30 Jan 2002 14:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290502AbSA3Tm1>; Wed, 30 Jan 2002 14:42:27 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60888 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290496AbSA3TmM>;
	Wed, 30 Jan 2002 14:42:12 -0500
Date: Wed, 30 Jan 2002 14:42:10 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Rob Landley <landley@trommello.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130144210.B1391@havoc.gtf.org>
In-Reply-To: <200201290446.g0T4kZU31923@snark.thyrsus.com> <20020130093741.JKWP18592.femail36.sdc1.sfba.home.com@there> <20020130044305.B11267@havoc.gtf.org> <20020130193920.XLYO7009.femail35.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130193920.XLYO7009.femail35.sdc1.sfba.home.com@there>; from landley@trommello.org on Wed, Jan 30, 2002 at 02:40:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:40:25PM -0500, Rob Landley wrote:
> On Wednesday 30 January 2002 04:43 am, Jeff Garzik wrote:
> > On Wed, Jan 30, 2002 at 04:38:51AM -0500, Rob Landley wrote:
> > > Considering how much he's been warned so far about the need for CML2 to
> > > maintain as much compatability as possible with CML1,
> >
> > Pardon me while I laugh my ass off.
> 
> [waits...]

Keep waiting, I'm still laughing.


> I'm under the impression CML2 already supports the split-up per-directory 
> help files, and did long before Linus actually split it up.  Therefore, Eric 
> hasn't entirely been ignoring the issue, has he?

>From the kernel's point of view, yes, he has.


> (By the way, if you really want to fix the current cml1 stuff in the 
> cheesiest manner possible, what would be wrong with some variant of "find . 
> -name "*.hlp" | xargs cat > oldhelpfile.hlp"?  Then the old help file becomes 
> a generated file of the new help files.  Why mess with tcl/tk?  Put it in the 
> make file as a dependency.  Pardon me if somebody fixed it last night, I seem 
> have 91 emails to wade through since then on the patch penguin fallout 
> alone...)

That's a hack.  Fix it the right way.

<broken record> this is a devel series, we can afford to wait for the
better fix </broken record>

	Jeff



Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314266AbSEXHcY>; Fri, 24 May 2002 03:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317104AbSEXHcY>; Fri, 24 May 2002 03:32:24 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6666
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314266AbSEXHcX>; Fri, 24 May 2002 03:32:23 -0400
Date: Fri, 24 May 2002 00:32:16 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: It hurts when I shoot myself in the foot
Message-ID: <20020524073216.GA1136@matchmail.com>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205221615.g4MGFCH30271@directcommunications.net> <acha7p$cge$1@cesium.transmeta.com> <20020523034821.GK458@turbolinux.com> <20020523044933.GB4006@matchmail.com> <20020523054219.GL458@turbolinux.com> <20020523173305.GC4006@matchmail.com> <20020524002829.A27005@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 12:28:29AM +0200, Vojtech Pavlik wrote:
> On Thu, May 23, 2002 at 10:33:05AM -0700, Mike Fedyk wrote:
> > On Wed, May 22, 2002 at 11:42:19PM -0600, Andreas Dilger wrote:
> > > On May 22, 2002  21:49 -0700, Mike Fedyk wrote:
> > > > On Wed, May 22, 2002 at 09:48:21PM -0600, Andreas Dilger wrote:
> > > > > There was a kernel patch posted about 5 or so months ago which would
> > > > > "handle" this setup (CPUs with the same clock speed, but different
> > > > > multipliers).  Alan Cox said it probably was a bad idea, so it wouldn't
> > > > > go into the kernel, but the patch may still be usable.
> > > > > 
> > > > > This is sometimes called "asymmetric multiprocessing", and the thread
> > > > > is at http://marc.theaimsgroup.com/?l=linux-kernel&m=98519070331478&w=4
> > > > 
> > > > I thought asymmetric multiprocessing would support CPUs with different
> > > > speeds.  ie, 400 & 450mhz.  How would you get different multipliers and same
> > > > Mhz when the CPUs are on the same FSB(ignoring AMD SMP where each processor
> > > > has an exclusive FSB, and this might be possible)?
> > > 
> > > That was what I was trying to say: same FSB speed * different multipliers
> > > = different CPU MHZ, like what the original poster is asking about.
> > > I don't think it is possible to configure a motherboard to have different
> > > FSB speeds for two processors.
> > >
> > 
> > Me neither, but it seems theoretically possible.
> 
> It is not, they are both on the same FSB, at least in Pentium II/III case.

And if you read even what is quoted above in this message you would notice
that we are not talking about Intel SMP, but AMD SMP, or more correctly, AMD
SMP licensed from Alpha.  What you say is true for Intel SMP though.

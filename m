Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSIZXgA>; Thu, 26 Sep 2002 19:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSIZXgA>; Thu, 26 Sep 2002 19:36:00 -0400
Received: from pc132.utati.net ([216.143.22.132]:62109 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261573AbSIZXf7>; Thu, 26 Sep 2002 19:35:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Larry Kessler <kessler@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
Date: Thu, 26 Sep 2002 14:41:06 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
References: <Pine.LNX.4.44L.0209261636340.1837-100000@duckman.distro.conectiva> <3D93678B.8EF7A420@us.ibm.com>
In-Reply-To: <3D93678B.8EF7A420@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020926233818.CE506398@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 September 2002 04:01 pm, Larry Kessler wrote:
> Rik van Riel wrote:
> > On Thu, 26 Sep 2002, Larry Kessler wrote:
> > > Distros could be motivated to provide translations, etc. for the kernel
> > > versions that they base new releases on.
> >
> > Unlikely.  It's hard enough already when somebody who doesn't
> > speak the language submits a bugreport by email or through
> > bugzilla.
> >
> > I don't want to imagine receiving a bug report from eg. Japan
> > that has a cut'n'pasted kernel error in Japanese. It's not just
> > that I can't read Japanese ... I don't even have the FONT to
> > display it.
>
> Right, so the tools that take kernel events and display them in
> human-readable form must be written to always display in english,
> with the option to also display in another language, thus allowing
> the non-English-reading SysAdmin in Japan to easily understand the
> info.

If your system is functional enough after the "event" that the user can make 
this selection and the system listens to them, then it can clearly be done in 
userspace.

Otherwise, the ability to select is kind of pointless.  It has to be done 
before you actually have a problem, and will result in swahili bug reports to 
the list because that's the language it was outputting when the problem 
happened and they can't necessarily reproduce the problem on demand.

Rob

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315169AbSD2TjY>; Mon, 29 Apr 2002 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315170AbSD2TjX>; Mon, 29 Apr 2002 15:39:23 -0400
Received: from mail.storm.ca ([209.87.239.66]:15041 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S315169AbSD2TjW>;
	Mon, 29 Apr 2002 15:39:22 -0400
Message-ID: <3CCD93E6.F637706A@storm.ca>
Date: Mon, 29 Apr 2002 14:41:42 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-26mdkenterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: The tainted message
In-Reply-To: <E171TzX-0008PF-00@the-village.bc.nu> <1019926629.2045.698.camel@phantasy> <1020099580.5131.14.camel@w-beattie1> <20020429171516.GA25377@louise.pinerecords.com> <20020429184331.3230f5ab.spyro@armlinux.org> <20020429174232.GA25502@louise.pinerecords.com> <ui6rcugr35a6h8u1tf6sq5js4mn5c19sq2@4ax.com> <20020429192107.GA26369@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tomas szepe wrote:

> > >> thie warning should be:
> > >>
> > >> Warning: Module %s is not open source, and as such, loading it will make
> > >> your kernel un-debuggable. Please do not submit bug reports from a kernel
> > >> with this module loaded, as they will be useless, and likely ignored.
> > >
> > >Very good! I'd only change the tense to "The non-opensource module %s is
> > >about to be loaded, which will make your kernel impossible to debug," so
> > >that it's crystal clear that the message is not a failure notification.
> >
> > Pschologically it would be better to phrase it as a postive statement.
> >
> > Warning: Module %s is not open source, and as such, loading it will
> > make your kernel un-debuggable. Before reporting problems to
> > Linux-kernel, please replicate the problem without the module loaded.
> 
> You're right. And, hmmm, tell you what.. I also like your version because
> it makes no statements whatsoever about vendor support, or support from
> anyone else than the people on linux-kernel.
> 
> Now, would anyone attempt to sum up all the points made here and come up
> w/ something like a "final-draft" proposal?

 
Warning: Source code for module %s is not publicly available. Problems
with a kernel that has loaded this module can be debugged only by someone
with access to the module source. Before reporting a problem to the Linux
kernel mailing list, please replicate the problem without the module loaded.

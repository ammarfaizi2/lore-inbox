Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUJNTsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUJNTsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUJNTqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:46:54 -0400
Received: from witte.sonytel.be ([80.88.33.193]:49905 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267353AbUJNTlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:41:50 -0400
Date: Thu, 14 Oct 2004 21:41:21 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Dave Jones <davej@redhat.com>, David Howells <dhowells@redhat.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <Pine.LNX.4.61.0410141455330.5232@chaos.analogic.com>
Message-ID: <Pine.GSO.4.61.0410142136200.99@waterleaf.sonytel.be>
References: <16349.1097752!349@redhat.com> <17271.1097756056@redhat.com>
 <Pine.LNX.4.53.0410140824490.363@chaos.analogic.com>
 <Pine.GSO.4.61.0410141617100.21062@waterleaf.sonytel.be>
 <Pine.LNX.4.53.0410141022180.1018@chaos.analogic.com>
 <Pine.LNX.4.53.0410141131190.7061@chaos.analogic.com> <20041014155030.GD26025@redhat.com>
 <Pine.LNX.4.61.0410141352590.8479@chaos.analogic.com> <20041014182052.GA18321@redhat.com>
 <Pine.LNX.4.61.0410141422530.1765@chaos.analogic.com> <20041014184635.GD18321@redhat.com>
 <Pine.LNX.4.61.0410141455330.5232@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Richard B. Johnson wrote:
> On Thu, 14 Oct 2004, Dave Jones wrote:
> > If you find things are still taking phenomenally
> > long times to build, then something is wrong somewhere.
> > Don't you find it strange you're the only person
> > to have complained about this ? If it was as big
> > a problem as you're suggesting, those of us who
> > do nothing but build kernels all day would be up in arms.
> 
> I think you guys probably got used to it. Also, you
> seldom build the whole thing, anymore, because the
> dependencies are handled differently. I was used to
> building stuff on 2.4.x. When I went to build stuff using
> the new build procedure I was shocked. It was like the
> old days with 66MHz '486s (fast) and 33MHz i386's. Of
> course there weren't modules, then so 2hrs,30min
> was normal. Now, with a CPU that's 80 times faster and
> a front-side bus that's 12 time faster, and SCSI
> disks that are 40 times faster, there just has to
> be something wrong when a complete build of the kernel
> takes an hour.

I have the impression 2.6 builds are more convenient, if not faster (sorry, no
hard data around due to ccache).

Perhaps you need to start using ccache (but that's true for building 2.4.x,
too)?

BTW, _if_ the build system got much slower, people who use ccache a lot would
notice, since the relative impact of the build system on the build time is
higher when using ccache.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131830AbRDTVTx>; Fri, 20 Apr 2001 17:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRDTVTm>; Fri, 20 Apr 2001 17:19:42 -0400
Received: from chromium11.wia.com ([207.66.214.139]:36878 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S131830AbRDTVTj>; Fri, 20 Apr 2001 17:19:39 -0400
Message-ID: <3AE0A8D2.3CD79B8D@chromium.com>
Date: Fri, 20 Apr 2001 14:23:30 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Zach Brown <zab@zabbo.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: numbers?
In-Reply-To: <Pine.LNX.4.30.0104202033160.2706-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> > On a Dell PowerEdge 1550/1000 the published TUX 2 result is 2765.
> >
> > If you take into account the fact that the 1550 has a faster processor
> > (1GHz) and a more modern bus architecture (Serverworks HE with memory
> > interleaving and a triple PCI bus), the performance is roughly the
> > same.
>
> the system was IO-limited (given that a ~9 GB fileset was running on a 2
> GB RAM system), so CPU speed has not a big impact. I'd say it makes no
> sense to compare different systems.

>From what I've seen the major impact comes from the disk IO bandwidth to
memory size ratio and from the PCI bus to memory bandwidth.

I agree that comparing different hardware architectures is a tricky business,
but you asked me to comment on some of the comparisons that you made...

> > The static pages work fine, the dynamic module gets executed, but for
> > some reason it fails to open the postlog file and to spawn the spec
> > utility tasks at reset time.
>
> the newest TUX code chroots into docroot, so you should either use "/" as
> the docroot, or put /lib libraries into your docroot.

Oh, the docs don't mention anything of that... I'll try to set the docroot as
you say

> > I'll make an alpha release of X15 available for download by the end of
> > next week, so people will be able to test it independently.
>
> (will source code be available so we can see whether it's an apples to
> apples thing?)

I'll release the source for the SPEC dynamic code dll, which indeed is just a
straight porting of the TUX dynamic code from the SPEC site.

 - Fabio



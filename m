Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283585AbRLDXcQ>; Tue, 4 Dec 2001 18:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283594AbRLDXcH>; Tue, 4 Dec 2001 18:32:07 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:43025 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S283585AbRLDXbv>;
	Tue, 4 Dec 2001 18:31:51 -0500
Date: Tue, 4 Dec 2001 21:31:40 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Lars Brinkhoff <lars.spam@nocrew.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Larry McVoy <lm@bitmover.com>, <hps@intermeta.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <2455827301.1007478174@mbligh.des.sequent.com>
Message-ID: <Pine.LNX.4.33L.0112042129160.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, Martin J. Bligh wrote:

> > Premise 3: it is far easier to take a bunch of operating system images
> >    and make them share the parts they need to share (i.e., the page
> >    cache), than to take a single image and pry it apart so that it
> >    runs well on N processors.
>
> Of course it's easier. But it seems like you're left with much more
> work to reiterate in each application you write to run on this thing.
> Do you want to do the work once in the kernel, or repeatedly in each
> application?

There seems to be a little misunderstanding here; from what
I gathered when talking to Larry, the idea behind ccClusters
is that they provide a single system image in a NUMA box, but
with separated operating system kernels.

Of course, this is close to what a "single" NUMA kernel often
ends up doing with much ugliness, so I think Larry's idea to
construct NUMA OSes by putting individual kernels of nodes to
work together makes a lot of sense.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/


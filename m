Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287113AbRL2EGs>; Fri, 28 Dec 2001 23:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287114AbRL2EGk>; Fri, 28 Dec 2001 23:06:40 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25791 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S287113AbRL2EG2>;
	Fri, 28 Dec 2001 23:06:28 -0500
Date: Fri, 28 Dec 2001 23:06:27 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228230627.B7801@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.33.0112281416290.23445-100000@penguin.transmeta.com> <7861.1009589244@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7861.1009589244@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Dec 29, 2001 at 12:27:24PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 12:27:24PM +1100, Keith Owens wrote:
> Dependencies _do_ change when your .config changes, the list of files
> that are included varies.

1) "#ifdef CONFIG_FOO #include ..." is usually wrong and a bug.  But
that is a tangent and I digress.

2) Such changes can be expressed without regenerating all dependencies.


> Linus, you have a choice between a known broken build system and a
> clean and reliable system, which is slightly slower in mark 1.  Please
> add kbuild 2.5 to the kernel,

Your system is known broken because it is 100% slower.

My kernel builds work just fine now, your changes gain me nothing,
while COSTING me productivity.  I see no gains, only costs, with your
kbuild-2.5 system as it exists.

Keith the target audience is Linus and Alan and ME etc.  We are the
kernel hackers that perform kernel -development-.  Making end-user
builds easier is NOT a primary nor secondary nor tertiary goal here.
Make my life easier first.  Fuck Aunt Tillie.  Aunt Tillie can get
her kernels from a vendor.

	Jeff



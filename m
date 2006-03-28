Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWC1R43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWC1R43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWC1R43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:56:29 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:50576 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932117AbWC1R42 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:56:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EpZOP3YZfG7BCUD/0kEi7mvTgw+TiD1S1ekybfM2HujRxGsSHCJOxawuUZvi1e7RAGorqmpa32WuGqnF9rdtotxDSHtBFEl2h+PKMJzYY9OK+YMxmUdAd/EZ5zmss3zoLBxoReu3p2tj2i7eh7UdZgiRMhlIAgd6KlO4m5+rtcM=
Message-ID: <9a8748490603280956o3234d3e4h5b3d16fe09dbf01a@mail.gmail.com>
Date: Tue, 28 Mar 2006 19:56:27 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Subject: Re: [OT] Non-GCC compilers used for linux userspace
Cc: "Eric Piel" <Eric.Piel@tremplin-utc.net>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Rob Landley" <rob@landley.net>, nix@esperi.org.uk, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
In-Reply-To: <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200603141619.36609.mmazur@kernel.pl>
	 <20060326065205.d691539c.mrmacman_g4@mac.com>
	 <4426A5BF.2080804@tremplin-utc.net>
	 <200603261609.10992.rob@landley.net>
	 <44271E88.6040101@tremplin-utc.net>
	 <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
	 <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr>
	 <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
	 <442960B6.2040502@tremplin-utc.net>
	 <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Mar 28, 2006, at 11:13:42, Eric Piel wrote:
> > 03/28/2006 05:57 PM, Kyle Moffett wrote/a écrit:
> >> But my question still stands.  Does anybody actually use any non-
> >> GCC compiler for userspace in Linux?
> >
> > At least in the domain of HPC, I've seen people which were
> > compiling mostly *everything* with the intel compiler (x86 and
> > ia64) for performance reason. So... yes userspace is sometimes
> > compiled with non-GCC compiler :-)
>
> Ok, well, the Intel compiler actually ends up emulating GCC and
> supports most of its extensions; supposedly it can even be used to
> compile the kernel sources, as per include/linux/compiler-intel.h. (I
> don't know how recently this has been tested, though)  So does
> anybody compile userspace under anything other than GCC or Intel
> compilers?  Do any such compilers even exist?
>

Other compilers do exist.

Over the years I've personally used a few to compile userspace apps
for different projects (though never for compiling the kernel).

Some of the compilers I have personally used for userspace apps on
Linux include ;

lcc   - http://www.cs.princeton.edu/software/lcc/
tcc   - http://fabrice.bellard.free.fr/tcc/

(plus gcc & icc ofcourse)


Others that I know of but have never used include :

sdcc   - http://sdcc.sourceforge.net/
Compaq C for Linux   - http://h30097.www3.hp.com/linux/compaq_c/index.html
Open Watcom   - http://www.openwatcom.org/
vacpp   - http://www-306.ibm.com/software/awdtools/vacpp/
XL C/C++   - http://www.absoft.com/Products/Compilers/C_C++/Linux/XLC/XLC.html

and I'm sure many more exist...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262398AbREUGMI>; Mon, 21 May 2001 02:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262399AbREUGL6>; Mon, 21 May 2001 02:11:58 -0400
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:8613 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S262398AbREUGLr>; Mon, 21 May 2001 02:11:47 -0400
Date: Mon, 21 May 2001 02:11:39 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "Robert M. Love" <rml@tech9.net>
cc: Jes Sorensen <jes@sunsite.dk>, John Cowan <jcowan@reutershealth.com>,
        <esr@thyrsus.com>, <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
In-Reply-To: <990411054.773.0.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0105210205520.1590-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 2001, Robert M. Love wrote:

>I think this is a very important point, and one I agree with.  I tend to
>let my distribution handle stuff like python.  now, I use RedHat's
>on-going devel, RawHide. it is not using python2.  in fact, since
>switching to python2 may break old stuff, I don't expect python2 until
>8.0. that wont be for 9 months.  90% of RedHat's configuration tools, et
>al, are written in python1 and they just are not going to change on
>someone's whim.
>
>im not installing python2 from source just so i can run some new config
>utility.
>
>(on another note, about the coexist issue: am i going to have a python
>and python2 binary? so now the config tool will find which to use, ala
>the kgcc mess? great)

powertools/7.1/SRPMS/python2-2.0-3.src.rpm

For the record, the kgcc "mess" you speak of was used by
Conectiva, and I believe also by debian before adoption in Red
Hat Linux.  It was about as good a solution as one could get for
the problem that it solved - the kernel being broken and unable
to build with our gcc-2.96.  Just to head anyone off at the
pass... the kernel is fixed and now builds properly with
gcc-2.96.  Also, if anyone has any questions about gcc-2.96
please see:

http://www.bero.org/gcc296.html

----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Open Source advocate
       Opinions and viewpoints expressed are solely my own.
----------------------------------------------------------------------
Microsoft Windows(tm). A 32 bit extension and graphical shell to a 16 bit 
patch to an 8 bit operating system originally coded for a 4 bit microprocessor
which was written by a 2 bit company that can't stand 1 bit of competition.


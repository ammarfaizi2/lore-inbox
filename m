Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288972AbSAUXO4>; Mon, 21 Jan 2002 18:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288966AbSAUXOg>; Mon, 21 Jan 2002 18:14:36 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13067 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288928AbSAUXOe>; Mon, 21 Jan 2002 18:14:34 -0500
Message-ID: <3C4C9F53.D6949776@zip.com.au>
Date: Mon, 21 Jan 2002 15:08:03 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Jeff Dike <jdike@karaya.com>, bulb@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 OOPS in tty code.
In-Reply-To: <200201212204.RAA03719@ccure.karaya.com>,
		<20020121151037.A21622@ucw.cz>
		<200201212204.RAA03719@ccure.karaya.com> <200201212247.g0LMlBU01766@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Jeff Dike writes:
> > bulb@ucw.cz said:
> > > Tty device code causes oopses when closing /dev/console and devfs is
> > > used. The bug is reproducible on 2.4.17 UML port.
> >
> > How do you reproduce it?
> >
> > UML config, command line, a backtrace, etc would be nice.
> 
> Furthermore, this was done without applying the latest devfs patch
> (v199.8 as I write this). Bug reports with old versions of devfs are
> (and should be) dropped in the bit-bucket, especially considering
> recent devfs patches have ChangeLog entries which talk about fixing
> Oopses!
> 

Jan's report seems to have nothing to do with devfs.  It
sounds like it's purely a tty-layer thing.

I'd like to see the full backtrace before we bitbucket
this one, please.


-

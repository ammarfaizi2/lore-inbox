Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSH1APy>; Tue, 27 Aug 2002 20:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSH1APy>; Tue, 27 Aug 2002 20:15:54 -0400
Received: from fmr05.intel.com ([134.134.136.6]:51907 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S317422AbSH1APx>; Tue, 27 Aug 2002 20:15:53 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB13299663@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "'H. Peter Anvin'" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: RE: Is it possible to use 8K page size on a i386 pc?
Date: Tue, 27 Aug 2002 17:19:54 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <200208271914.g7RJEQE07821@devserv.devel.redhat.com>
> By author:    Pete Zaitcev <zaitcev@redhat.com>
> In newsgroup: linux.dev.kernel
> > 
> > You may run into trouble with something that calls mmap with
> > a fixed address, with executables which have text sizes of
> > odd number of small pages. I was told that these problems are
> > fairly rare.
> > 
> 
> Only 50% of all binaries are affected... that's fairly rare :)

The majority of x86 linux binaries run on ia64 with a 16K
pagesize (admittedly with some not-so-pretty code to fudge
mmap/munmap addresses ... but it is proof that you can reduce
the problems to "fairly rare").

-Tony

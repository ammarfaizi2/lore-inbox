Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSELKkC>; Sun, 12 May 2002 06:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSELKkB>; Sun, 12 May 2002 06:40:01 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:6407 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312457AbSELKkA>; Sun, 12 May 2002 06:40:00 -0400
Date: Sun, 12 May 2002 12:39:46 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre8-ac2 kbuild 2.4 tmp_include_depends
Message-ID: <20020512103946.GB3749@louise.pinerecords.com>
In-Reply-To: <20020512090450.GA481@neon> <22198.1021198306@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 1 day, 4:41)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Keith Owens <kaos@ocs.com.au>, May-12 2002, Sun, 20:11 +1000]
> On Sun, 12 May 2002 11:04:50 +0200, 
> "Axel H. Siebenwirth" <axel@hh59.org> wrote:
> >make: *** No rule to make target .tmp_include_depends', needed by
> >=1Fdir_kernel'.  Stop.
> 
> Missed one occurrence of .tmp_include_depends.  Edit Makefile, find
> $(patsubst %, _dir_%, $(SUBDIRS)) and change .tmp_include_depends to
> tmp_include_depends (no '.' at start).
> 
> Corrected patch against 2.4.19-pre8-ac2.


Great work, Keith!
"make modules_install" takes like 2 seconds w/ -ac now!

T.

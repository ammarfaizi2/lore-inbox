Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSEMNCK>; Mon, 13 May 2002 09:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSEMNCJ>; Mon, 13 May 2002 09:02:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10250 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313238AbSEMNCI>; Mon, 13 May 2002 09:02:08 -0400
Date: Mon, 13 May 2002 14:01:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Dave Gilbert (Home)" <gilbertd@treblig.org>
Cc: Tomas Szepe <szepe@pinerecords.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513140158.B6024@flint.arm.linux.org.uk>
In-Reply-To: <20020512145802Z313578-22651+30503@vger.kernel.org> <Pine.LNX.4.44L.0205122146310.32261-100000@imladris.surriel.com> <20020513115800.GC4258@louise.pinerecords.com> <3CDFB41A.6070701@treblig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 01:39:54PM +0100, Dave Gilbert (Home) wrote:
> Tomas Szepe wrote:
> 
> > Alright, another one.
> > 
> > $ ./fmtcl2.pl /usr/src/ChangeLog-2.5.14
> > 
> > Summary of changes from v2.5.13 to v2.5.14
> > ============================================
> > 
> > o  kd.h                                                                             (Andries.Brouwer@cwi.nl)
> > o  NTFS: Release 2.0.6 - Major bugfix to make compatible with other kernel changes. (aia21@cantab.net)
> > o  mm/memory.c:                                                                     (aia21@cantab.net)
> > o  suppress allocation warnings for radix-tree allocations                          (akpm@zip.com.au)
> 
> <snip>
> 
> Ah - thats it!

Not quite.  In mutt, it looks like this:

o  kd.h
+(Andries.Brouwer@cwi.nl)
o  NTFS: Release 2.0.6 - Major bugfix to make compatible with other kernel
+changes. (aia21@cantab.net)
o  mm/memory.c:
+(aia21@cantab.net)
o  suppress allocation warnings for radix-tree allocations
+(akpm@zip.com.au)
o  radix-tree locking fix
+(akpm@zip.com.au)
o  Allow truncate to discard unmapped buffers
+(akpm@zip.com.au)
o  decouple swapper_space treatment from other address_spaces

NOT easy to read.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315524AbSECBUV>; Thu, 2 May 2002 21:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSECBUU>; Thu, 2 May 2002 21:20:20 -0400
Received: from ccs.covici.com ([209.249.181.196]:39576 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S315524AbSECBUT>;
	Thu, 2 May 2002 21:20:19 -0400
Date: Thu, 2 May 2002 21:19:53 -0400 (EDT)
From: John Covici <covici@ccs.covici.com>
To: Dave Jones <davej@suse.de>
cc: tomas szepe <kala@pinerecords.com>, Keith Owens <kaos@ocs.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <20020502234202.X16935@suse.de>
Message-ID: <Pine.LNX.4.40.0205022117350.17239-100000@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what should it point to?  I have had more trouble when some Debian
package made it not a symlink and if I tried to compile something
which needed correct headers for the version I am using I get very
strange errors which are hard to diagnose.

On Thu, 2 May 2002, Dave Jones wrote:

> On Thu, May 02, 2002 at 11:34:44PM +0200, tomas szepe wrote:
>  > '/usr/include/asm' points to '/usr/src/linux/include/asm'
>
> Therein lies your problem.
> /usr/include/asm should NOT be a symlink.  At least, not in this century.
>
>

-- 
         John Covici
         covici@ccs.covici.com


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSECSmO>; Fri, 3 May 2002 14:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315587AbSECSmN>; Fri, 3 May 2002 14:42:13 -0400
Received: from msp-65-29-16-52.mn.rr.com ([65.29.16.52]:57728 "HELO
	local.enodev.com") by vger.kernel.org with SMTP id <S315487AbSECSmJ>;
	Fri, 3 May 2002 14:42:09 -0400
Date: Fri, 3 May 2002 13:42:08 -0500
From: Shawn <core@enodev.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LINK FAILURE] 2.5.12-dj1 (mark_buffer_uptodate)
Message-ID: <20020503184208.GA25124@local.enodev.com>
In-Reply-To: <20020503181719.GA20588@local.enodev.com> <20020503203752.C30500@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. Just seconds ago, I looked at the various clues in
patch-2.5.12.bz2 on what exactly I had to do. Kindof a no-brainer for me
to be asking about.

Didn't know .13 was out. I'll have to run that one instead, as I have
been noticing .12 getting lots of reports on various things.

Trying to track linux-current again is always a fun adventure! Thanks!

On 05/03, Dave Jones said something like:
> On Fri, May 03, 2002 at 01:17:19PM -0500, Shawn wrote:
>  > Searched the archives, and didn't find anything.
>  > 
>  > Could someone point me in the right direction to get this compiled?
>  > 
>  > drivers/block/block.o(.text+0xc514): undefined reference to `mark_buffer_uptodate'
>  
> I'm creating the 2.5.13-dj1 diff this minute, so that should be up real
> soon now, which fixes this.  If you can't wait that long 8-), the fix is
> to change that line to read set_buffer_uptodate(tmp);
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
--
Shawn Leas
core@enodev.com

I got food poisoning today.  I don't know when I'll use it.
						-- Stephen Wright

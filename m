Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293691AbSCFRAc>; Wed, 6 Mar 2002 12:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293689AbSCFRAY>; Wed, 6 Mar 2002 12:00:24 -0500
Received: from bitmover.com ([192.132.92.2]:7655 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293687AbSCFRAM>;
	Wed, 6 Mar 2002 12:00:12 -0500
Date: Wed, 6 Mar 2002 09:00:11 -0800
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andi Kleen <ak@suse.de>,
        Andrew Morton <akpm@zip.com.au>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020306090011.G15303@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Andi Kleen <ak@suse.de>,
	Andrew Morton <akpm@zip.com.au>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0203061424190.14695-100000@vervain.sonytel.be> <Pine.LNX.4.21.0203061525160.6899-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0203061525160.6899-100000@serv>; from zippel@linux-m68k.org on Wed, Mar 06, 2002 at 03:30:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 03:30:03PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 6 Mar 2002, Geert Uytterhoeven wrote:
> 
> > > I also prefer not to use Bitkeeper as long as possible for similar reasons 
> > > and because it is too slow and clumpsy 
> > > (although it is already very hard because often source is only available 
> > > through it, e.g. for ppc or for 2.5 pre patches now -- hopefully this trend
> > > does not continue)
> > 
> > The PPC trees are available through rsync as well.
> > 
> >     http://www.penguinppc.org/dev/kernel.shtml
> 
> With rsync you get only the latest version, but not any previous
> version. For APUS I have to use bk to extract the ppc tree version I want
> to import, for m68k I only have to go to ftp.kernel.org and grab the right
> patch.

Is the problem that you can't figure out how to extract all the patches
from BK so you can put them up for FTP?  Here, I'll do it for you:

	# extract all the patches from 2.5.0 onward.
	bk prs -hrv2.5.0.. |  while read x
	do	bk export -tpatch -r$i > ~ftp/patches/patch-$i
	done

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

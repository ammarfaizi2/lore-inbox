Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSLYSQH>; Wed, 25 Dec 2002 13:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSLYSQH>; Wed, 25 Dec 2002 13:16:07 -0500
Received: from h002.c000.snv.cp.net ([209.228.32.66]:11678 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id <S262380AbSLYSQG>;
	Wed, 25 Dec 2002 13:16:06 -0500
X-Sent: 25 Dec 2002 18:24:18 GMT
Subject: Re: Next round of AGPGART fixes.
From: "Alfred E. Heggestad" <linuxedmund@home.no>
To: Florin Iucha <florin@iucha.net>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021222183657.GA1043@iucha.net>
References: <20021220124137.GA28068@suse.de>
	 <20021222155211.GB650@iucha.net>  <20021222183657.GA1043@iucha.net>
Content-Type: text/plain
Organization: SX Design
Message-Id: <1040840483.486.2.camel@io>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 25 Dec 2002 19:21:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-22 at 19:36, Florin Iucha wrote:
> On Sun, Dec 22, 2002 at 09:52:11AM -0600, Florin Iucha wrote:
> > On Fri, Dec 20, 2002 at 12:41:37PM +0000, Dave Jones wrote:
> > > Linus,
> > >  Please pull from bk://linux-dj.bkbits.net/agpgart to get at the
> > > following fixes..
> > [snip]
> > > GNU diff for those who care (against Linus' bk tree) is at
> > > ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.52/agpgart-fixes-1.diff
> > 
> > I'm using bk7 which contains all your patch except via* stuff which I'm
> > not interested in.
> > Agpgart and sis-agp compiled as modules. Modprobe agpgart succeeds, 
> > modprobe sis-agp oopses:
> > 
> > agpgart: Detected SiS 735 chipset
> 
> [snip oops]
> 
> With agpgart and sis-agp built in the kernel (non-modular) it works
> fine - I have direct rendering enabled in X.
> 
> Cheers,
> florin

I also had this problem with 2.5.51 and 2.5.52. Just tried 2.5.53
last night and now /dev/agpgart works fine again (static kernel,
no modules). Thanks.

/alfred

-- 
/**
 * Alfred E. Heggestad - Coder
 */


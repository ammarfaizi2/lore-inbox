Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268954AbRHLE7X>; Sun, 12 Aug 2001 00:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268957AbRHLE7N>; Sun, 12 Aug 2001 00:59:13 -0400
Received: from ppp42.ts4-2.NewportNews.visi.net ([209.8.198.234]:36349 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S268954AbRHLE7I>; Sun, 12 Aug 2001 00:59:08 -0400
Date: Sun, 12 Aug 2001 00:58:51 -0400
From: Ben Collins <bcollins@debian.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@zip.com.au>, ext3-users@redhat.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.6
Message-ID: <20010812005850.T30381@visi.net>
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>, <3B75DE86.EEDFAFFB@zip.com.au> <20010811184640.B17435@cpe-24-221-152-185.az.sprintbbd.net> <3B75E1F9.2BF5D4B6@zip.com.au>, <3B75E1F9.2BF5D4B6@zip.com.au> <20010811191539.C17435@cpe-24-221-152-185.az.sprintbbd.net> <3B75E9E3.FAAF05CC@zip.com.au> <20010811194744.B17668@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010811194744.B17668@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Sat, Aug 11, 2001 at 07:47:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 07:47:44PM -0700, Tom Rini wrote:
> On Sat, Aug 11, 2001 at 07:28:51PM -0700, Andrew Morton wrote:
> > Well, LILO works OK with an unclean ext3 FS because it goes straight to
> > the underlying blocks.  If both grub and OF parse the superblock compatibility
> > bits then they could fail in this manner.
> 
> Both GRUB and yaboot can read directly from the fs.  It's possible to boot
> a kernel right out of OF from an HFS partition (which I had to do to get
> the box up again).  It might be worth documenting this someplace.

Same goes for SILO too. Not sure if SILO even works with ext3 right now
(uses libext2fs, so I assume so).

Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'

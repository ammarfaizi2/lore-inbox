Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274072AbRIXR3Q>; Mon, 24 Sep 2001 13:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274074AbRIXR24>; Mon, 24 Sep 2001 13:28:56 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:12164
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S274072AbRIXR2s>; Mon, 24 Sep 2001 13:28:48 -0400
Date: Mon, 24 Sep 2001 10:29:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.10
Message-ID: <20010924102905.A26035@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3BAECC4F.EF25393@zip.com.au>, <3BAECC4F.EF25393@zip.com.au> <20010924101602.A25956@cpe-24-221-152-185.az.sprintbbd.net> <3BAF6B32.9E41CD19@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAF6B32.9E41CD19@zip.com.au>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 10:19:46AM -0700, Andrew Morton wrote:
> Tom Rini wrote:
> > 
> > On Sun, Sep 23, 2001 at 11:01:51PM -0700, Andrew Morton wrote:
> > 
> > > An ext3 patch against linux 2.4.10 is at
> > >
> > >       http://www.uow.edu.au/~andrewm/linux/ext3/
> > >
> > > This patch is *lightly tested* - ie, it boots and does stuff.
> > > The changes to ext3 are small, but the kernel which it patches
> > > has recently changed a lot.  If you're cautious, please wait
> > > a couple of days.
> > 
> > This doesn't  compile for me:
> > gcc -D__KERNEL__ -I/home/trini/work/kernel/testing/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -DEXPORT_SYMTAB -c jbd-kernel.c
> > jbd-kernel.c: In function `b_list_to_string':
> > jbd-kernel.c:209: `BUF_PROTECTED' undeclared (first use in this function)
> 
> Yes, sorry.  Delete line 209 of jdb-kernel.c, or don't compile with
> buffer-debug.

Okay.  BTW, my ppc box is at 26 days with ext3-0.9.6-2.4.9 right now, so 
hopefully all the endian bugs are gone.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

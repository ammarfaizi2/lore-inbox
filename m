Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRLDSbA>; Tue, 4 Dec 2001 13:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281156AbRLDS3m>; Tue, 4 Dec 2001 13:29:42 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:64424
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S283251AbRLDSZU>; Tue, 4 Dec 2001 13:25:20 -0500
Date: Tue, 4 Dec 2001 11:24:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Giacomo Catenazzi <cate@dplanet.ch>, Wayne.Brown@altec.com,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204182451.GN17651@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3C0D0BFD.6080903@dplanet.ch> <E16BKBw-0002xO-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16BKBw-0002xO-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:21:15PM +0000, Alan Cox wrote:
> > make bzlilo modules modules_install: it would be a simble
> > make install: (and you configure with CML1/CML2 what install
> > means).
> 
> How does it handle that when install means different things on each box of
> a set of them NFS sharing the kernel tree. This is a real world example

I'd guess  you can change the module install path, and re-run 'install'
without having anything rebuilt.  Admiditly a bit worse off than
INSTALL_MOD_PATH=/nfs/boxA.  Or set the install paths to
.../kernel-XXX/, tar and untar.

Or if /usr/local/src/linux is NFS'ed, and you're installing per box, I
don't get it.  Wouldn't you always install modules into /lib/modules/XXX
?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

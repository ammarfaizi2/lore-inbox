Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289741AbSAOXXr>; Tue, 15 Jan 2002 18:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289754AbSAOXXa>; Tue, 15 Jan 2002 18:23:30 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:62592
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289741AbSAOXXY>; Tue, 15 Jan 2002 18:23:24 -0500
Date: Tue, 15 Jan 2002 16:22:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
        arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020115232252.GC5220@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E16QESB-0002xq-00@the-village.bc.nu> <195317834.1011133033@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195317834.1011133033@[195.224.237.69]>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 10:17:13PM -0000, Alex Bligh - linux-kernel wrote:
 
> & if this is the sole aim, just (configurably no doubt) stick
> .config somewhere in initramfs as part of the build process
> and you have no parsing to do whatsoever.

initramfs goes away, I believe.  But most vendors stick their config in
/boot/config-`uname -r`, and last I looked at kbuild-2.5, it asked if
you wanted to stick your .config in /lib/modules/`uname -r` (which is
default loc for System.map too..)  Or maybe it just did it.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

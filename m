Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWHLQam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWHLQam (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWHLQam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:30:42 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:43665 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S964857AbWHLQam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:30:42 -0400
Date: Sat, 12 Aug 2006 18:30:30 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Alex Riesen <raa.lkml@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc: "make install" broken
Message-ID: <20060812163030.GA5232@aepfle.de>
References: <81b0412b0608120729m42b0c5b5n9f0a06b27796452c@mail.gmail.com> <20060812143451.GA18642@mars.ravnborg.org> <81b0412b0608120759h313bbdc9hfd6e3b3acd8a3d3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81b0412b0608120759h313bbdc9hfd6e3b3acd8a3d3d@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 04:59:24PM +0200, Alex Riesen wrote:
> On 8/12/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> >> I don't know if ever worked before, just tried today on v2.6.17.
> >> Maybe it works, but then it is very different to i386
> >> where it is plain "make install".
> >>
> >> I copied the implementation attached from i386 (modified a bit), which
> >> fixed it for me. Maybe the patch will motivate someone to fix it 
> >properly...
> >NACK - the install target shall not try to build the kernel - the
> >vmlinux dependency is long gone from i386.
> 
> Agreed, updated, rediffed, attached

does it do the same as before? $BOOTIMAGE handling may be broken.
At least $5 is not handled anymore, someone else broke it without updating the comment.


> (sorry for attach, that's gmail).

there is no excuse for using gmail...

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSCKUlB>; Mon, 11 Mar 2002 15:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292883AbSCKUkv>; Mon, 11 Mar 2002 15:40:51 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:37504
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S292730AbSCKUkp>; Mon, 11 Mar 2002 15:40:45 -0500
Date: Mon, 11 Mar 2002 13:39:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [bkpatch] do_mmap cleanup
Message-ID: <20020311203947.GA735@opus.bloom.county>
In-Reply-To: <20020308185350.E12425@redhat.com> <20020311120818.A38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311120818.A38@toy.ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 12:08:18PM +0000, Pavel Machek wrote:
> Hi!
> 
> > Below is a vm cleanup that can be pulled from bk://bcrlbits.bk.net/vm-2.5 .
> > The bulk of the patch is moving the down/up_write on mmap_sem into do_mmap 
> > and removing that from all the callers.  The patch also includes a fix for 
> > do_mmap which caused mapping of the last page in the address space to fail.
> 
> Was not that a workaround for CPU bugs?

In generic code, I'd hope not.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

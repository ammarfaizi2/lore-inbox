Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312095AbSCTUC6>; Wed, 20 Mar 2002 15:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312096AbSCTUCs>; Wed, 20 Mar 2002 15:02:48 -0500
Received: from ns.suse.de ([213.95.15.193]:9996 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312095AbSCTUCh>;
	Wed, 20 Mar 2002 15:02:37 -0500
Date: Wed, 20 Mar 2002 21:02:36 +0100
From: Dave Jones <davej@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Adrian Bunk <bunk@fs.tum.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-160-lru_release_check
Message-ID: <20020320210236.K5094@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andrew Morton <akpm@zip.com.au>, Adrian Bunk <bunk@fs.tum.de>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C980990.1C6B232A@zip.com.au> <Pine.NEB.4.44.0203201703450.3932-100000@mimas.fachschaften.tu-muenchen.de> <3C98E2E4.A42B13D0@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 11:28:36AM -0800, Andrew Morton wrote:
 > > Is there a reason against intruducing BUG_ON in 2.4? It makes such things
 > > more readable.
 > I hate BUG_ON() :)  It's arse-about so you have to stare at it furiously
 > to understand why your kernel still works.

 Preach on brother Morton.
 
 > I hope the Nobel committee is reading this mailing list: how
 > about assert()?

 Quite a few places in the kernel already are.
 See drivers/net/pci-skeleton.c for one.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

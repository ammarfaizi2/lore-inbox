Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSCKSe4>; Mon, 11 Mar 2002 13:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSCKSeq>; Mon, 11 Mar 2002 13:34:46 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:4623 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S285424AbSCKSeo>;
	Mon, 11 Mar 2002 13:34:44 -0500
Date: Mon, 11 Mar 2002 12:08:18 +0000
From: Pavel Machek <pavel@suse.cz>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [bkpatch] do_mmap cleanup
Message-ID: <20020311120818.A38@toy.ucw.cz>
In-Reply-To: <20020308185350.E12425@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020308185350.E12425@redhat.com>; from bcrl@redhat.com on Fri, Mar 08, 2002 at 06:53:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Below is a vm cleanup that can be pulled from bk://bcrlbits.bk.net/vm-2.5 .
> The bulk of the patch is moving the down/up_write on mmap_sem into do_mmap 
> and removing that from all the callers.  The patch also includes a fix for 
> do_mmap which caused mapping of the last page in the address space to fail.

Was not that a workaround for CPU bugs?
									Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


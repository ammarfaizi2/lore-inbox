Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317390AbSGOInr>; Mon, 15 Jul 2002 04:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317391AbSGOInq>; Mon, 15 Jul 2002 04:43:46 -0400
Received: from ns.suse.de ([213.95.15.193]:42756 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317390AbSGOInq>;
	Mon, 15 Jul 2002 04:43:46 -0400
Date: Mon, 15 Jul 2002 10:46:30 +0200
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020715104629.A11096@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <20020711230222.GA5143@kroah.com> <agtn5j$ij2$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtn5j$ij2$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 05:38:59AM +0000, Linus Torvalds wrote:
 > > drivers/char/agp/agpgart_be-via.c    |  151 +
 > Ok, so is there any real _reason_ to have filenames quite this ugly?

of course not. I'll fix it up later, and send an updated patch
with 1-2 other small changes that happened since Greg's work
(one of the Intel backends had a subtle thinko brought forward
 from 2.4.19rc1)

 > If you want the redundancy, duplication and profusion, please keep it
 > shorter.  And put it at the end, so that at least filename completion
 > works well: "via-agp.c".
 > 
 > Ok?

Ok, I think we can even do away with the -agp, as we're in the
agp/ dircetory, which again seems to be pointless duplication.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSLJND7>; Tue, 10 Dec 2002 08:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSLJND7>; Tue, 10 Dec 2002 08:03:59 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:39113 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261409AbSLJND6>; Tue, 10 Dec 2002 08:03:58 -0500
Date: Tue, 10 Dec 2002 13:11:43 +0000
From: Dave Jones <davej@suse.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
Message-ID: <20021210131143.GA26361@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Antonino Daplas <adaplas@pol.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1039522886.1041.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039522886.1041.17.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 05:21:29PM +0500, Antonino Daplas wrote:
 > Hi,
 > 
 > 1.  Agpgart is broken for i810, and perhaps some of the i815 family. The
 > following lines (linux/drivers/char/agp/backend.c:120)

Yup, known problem. On my TODO.

 > 2.  The i810 driver for Xfree86 will also fail to load because of
 > version mismatch (0.99 vs 1.0).  Rolling back the version corrects the
 > problem.

Ugh, that's great. So X has to be patched every time the agpgart code
gets a new revision ? That sounds really unpleasant.

 > No patches because I don't want to uglify the code :-)

I'll ping you when I have something to test.

        Dave


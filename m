Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbSLKR7q>; Wed, 11 Dec 2002 12:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbSLKR7q>; Wed, 11 Dec 2002 12:59:46 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:15233 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267245AbSLKR7p>;
	Wed, 11 Dec 2002 12:59:45 -0500
Date: Wed, 11 Dec 2002 18:07:19 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Changes doc update.
Message-ID: <20021211180719.GB10008@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021211172559.GA8613@suse.de> <20021211175810.GC2612@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211175810.GC2612@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 12:58:10PM -0500, Jeff Garzik wrote:
 > I think the coolest things (to me) of the new build system need to be
 > noted too,
 > 
 > - "make" is now the preferred target; it does <arch-zimage> and modules.
 > - "make -jN" is now the preferred parallel-make execution.  Do not
 >   bother to provide "MAKE=xxx".

Yup. Added. Thanks.
Something else that I've noticed (but not found documented) is that
make dep seems to be automagickly done somewhen. An explicit make dep
takes about a second, and doesn't seem to do much at all.

Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

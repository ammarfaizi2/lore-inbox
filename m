Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbTALOrU>; Sun, 12 Jan 2003 09:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbTALOrU>; Sun, 12 Jan 2003 09:47:20 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:30089 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267098AbTALOrT>;
	Sun, 12 Jan 2003 09:47:19 -0500
Date: Sun, 12 Jan 2003 14:52:52 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, arjanv@redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [BK/PATCH] better i386 compiler flags
Message-ID: <20030112145252.GA6582@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, arjanv@redhat.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20030111012645.GB24847@gtf.org> <20030112000601.GE25493@codemonkey.org.uk> <20030111232939.A25494@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111232939.A25494@twiddle.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:29:39PM -0800, Richard Henderson wrote:
 > On Sun, Jan 12, 2003 at 12:06:02AM +0000, Dave Jones wrote:
 > > As a heads up, judging from gcc-patches, it seems that the gcc folks are
 > > changing -march over to -mtune at some point soon. I can't fathom the
 > > reasoning behind this other than causing a PITA for users.
 > No, -mcpu -> -mtune.  Reason: mcpu means different things
 > to different targets, and it's confusing.

Ah, right. It's still going to make the checkgcc macros in
arch/i386/Makefile get even more 'interesting' though 8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk

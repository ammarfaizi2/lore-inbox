Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbTALAAM>; Sat, 11 Jan 2003 19:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268183AbTALAAM>; Sat, 11 Jan 2003 19:00:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:22663 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267215AbTALAAL>;
	Sat, 11 Jan 2003 19:00:11 -0500
Date: Sun, 12 Jan 2003 00:06:02 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, arjanv@redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [BK/PATCH] better i386 compiler flags
Message-ID: <20030112000601.GE25493@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, arjanv@redhat.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20030111012645.GB24847@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111012645.GB24847@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 08:26:46PM -0500, Jeff Garzik wrote:
 > [this kills scads of warnings with CONFIG_MCYRIXIII and gcc 3.2,
 >  also starts using -march=pentium3/4/athlon when available.  I've been
 >  doing that for a while now without problems.]

As a heads up, judging from gcc-patches, it seems that the gcc folks are
changing -march over to -mtune at some point soon. I can't fathom the
reasoning behind this other than causing a PITA for users.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

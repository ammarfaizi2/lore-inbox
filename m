Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267323AbTALHVN>; Sun, 12 Jan 2003 02:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268248AbTALHVN>; Sun, 12 Jan 2003 02:21:13 -0500
Received: from are.twiddle.net ([64.81.246.98]:48517 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267323AbTALHVM>;
	Sun, 12 Jan 2003 02:21:12 -0500
Date: Sat, 11 Jan 2003 23:29:39 -0800
From: Richard Henderson <rth@twiddle.net>
To: Dave Jones <davej@codemonkey.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, arjanv@redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [BK/PATCH] better i386 compiler flags
Message-ID: <20030111232939.A25494@twiddle.net>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, arjanv@redhat.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20030111012645.GB24847@gtf.org> <20030112000601.GE25493@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030112000601.GE25493@codemonkey.org.uk>; from davej@codemonkey.org.uk on Sun, Jan 12, 2003 at 12:06:02AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 12:06:02AM +0000, Dave Jones wrote:
> As a heads up, judging from gcc-patches, it seems that the gcc folks are
> changing -march over to -mtune at some point soon. I can't fathom the
> reasoning behind this other than causing a PITA for users.

No, -mcpu -> -mtune.  Reason: mcpu means different things
to different targets, and it's confusing.


r~

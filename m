Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266259AbUHKDl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUHKDl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 23:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUHKDl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 23:41:57 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:23039 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266259AbUHKDlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 23:41:55 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Albert Cahalan <albert@users.sf.net>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Con Kolivas <kernel@kolivas.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
In-Reply-To: <200408110159.57325.jk-lkml@sci.fi>
References: <1092082920.5761.266.camel@cube>
	 <cone.1092113232.42936.29067.502@pc.kolivas.org>
	 <1092106283.5761.304.camel@cube>  <200408110159.57325.jk-lkml@sci.fi>
Content-Type: text/plain
Organization: 
Message-Id: <1092186590.5759.665.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Aug 2004 21:09:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 18:59, Jan Knutar wrote:
> > Light web browsing makes my
> > mp3 player skip.
> 
> What kind of machine is that? I've never needed to boost priority for the mp3
> player on my P133, even when running opera and/or mozilla... 

Since the last time I tested this, things have
improved dramatically. This is 2.6.8-rc1 now; I had
been mostly using 2.6.0-test5 and 2.6.0-test11.
Still, I do get problems from:

1. resizing any window (oroborus wm + GNOME)
2. switching out of X with Alt-Ctrl-F1
3. switching into X with Alt-Ctrl-F7

I suppose this means that it is somewhat likely that
burning a CD without CAP_SYS_RESOURCE would work.
I doubt I'd like to risk my time and money on this,
but at least it isn't looking like failure would
be much more likely than success.

It irritates me that I'd need to compile up a hacked
cdrecord in order to attempt a dummy burn as a
regular user. Those warnings are treated as errors.
Grrr... If SuSE, OSDL, IBM, SGI, HP or Red Hat would
put up the money, I'd gladly fix this POS. Anybody
care enough?

FWIW, my desktop machine is:

450 MHz Mac G4 Cube, 512 MB RAM, 1600x1024 32bpp,
5400 rpm IDE, ext2, no swap, 2.6.8-rc1 kernel,
USB audio, ATI Rage 128 PF/PRO AGP 4x TMDS video

I run sound through esd, like this: mpg321 -o esd ...

Commonly, the X server grows to 300 MB and/or Mozilla
grows to 200 MB before I restart them. An old GNOME
is running with 8 desktops, Evolution and one or two
dozen xterms.



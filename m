Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVAXPII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVAXPII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 10:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVAXPII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 10:08:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18615 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261519AbVAXPID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 10:08:03 -0500
Date: Mon, 24 Jan 2005 16:07:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       linux-kernel@vger.kernel.org
Subject: Re: DVD burning still have problems
Message-ID: <20050124150755.GH2707@suse.de>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de> <5a4c581d050123125967a65cd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d050123125967a65cd7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23 2005, Alessandro Suardi wrote:
> On Sun, 23 Jan 2005 21:26:55 +0100, Volker Armin Hemmann
> <volker.armin.hemmann@tu-clausthal.de> wrote:
> > Hi,
> > 
> > have you checked, that cdrecord is not suid root, and growisofs/dvd+rw-tools
> > is?
> > 
> > I had some probs, solved with a simple chmod +s growisofs :)
> 
> Lucky you. Burning as root here, cdrecord not suid. Tried also
>  burning with a +s growisofs, but...
> 
>  794034176/4572807168 (17.4%) @2.4x, remaining 18:47
>  805339136/4572807168 (17.6%) @2.4x, remaining 18:42
> :-[ WRITE@LBA=60eb0h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output error
> builtin_dd: 396976*2KB out @ average 2.4x1385KBps
> :-( write failed: Input/output error

As with the original report, the drive is sending back a write error to
the issuer. Looks like bad media.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUJEX3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUJEX3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUJEX3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:29:54 -0400
Received: from sa6.bezeqint.net ([192.115.104.20]:60574 "EHLO sa6.bezeqint.net")
	by vger.kernel.org with ESMTP id S266362AbUJEX1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:27:09 -0400
Date: Wed, 6 Oct 2004 01:28:18 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3 lost cdrom
Message-ID: <20041005232818.GA3084@luna.mooo.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041003021055.GA3227@luna.mooo.com> <20041004061902.GC2287@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004061902.GC2287@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 08:19:06AM +0200, Jens Axboe wrote:
> On Sun, Oct 03 2004, Micha Feigin wrote:
> > I seem to have lost cdrom support through scsi emulation, any ideas?
> > (its a burner, and drive detection with xcdroast in ide mode is
> > terrible, takes minutes).
> 
> So did it work in 2.6.9-rc2?
> 

It turned out to be hardware problems. Cleaned it with some compressed
air and it works for now (hopefully that was the only problem).

On the other had, ide-scsi still segfaults when trying to remove it
(seems to be no relation to the faulty cd drive).

The stack trace is in the other mail I sent.

> -- 
> Jens Axboe
> 
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 

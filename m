Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVGHIvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVGHIvh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVGHIvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:51:37 -0400
Received: from styx.suse.cz ([82.119.242.94]:8930 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262273AbVGHItp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:49:45 -0400
Date: Fri, 8 Jul 2005 10:49:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: 7eggert@gmx.de
Cc: Clemens Koller <clemens.koller@anagramm.de>, Jens Axboe <axboe@suse.de>,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]  IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050708084943.GA1035@ucw.cz>
References: <4msWl-Yq-5@gated-at.bofh.it> <4mtza-1vg-15@gated-at.bofh.it> <4mtII-1Ab-13@gated-at.bofh.it> <4mtSm-1FA-5@gated-at.bofh.it> <4mtSn-1FA-11@gated-at.bofh.it> <4mwx1-3N9-25@gated-at.bofh.it> <4mx9A-4qm-1@gated-at.bofh.it> <4nzCr-6fN-19@gated-at.bofh.it> <4nI36-527-9@gated-at.bofh.it> <E1DqhA2-000200-15@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DqhA2-000200-15@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:56:08AM +0200, Bodo Eggert wrote:

> Clemens Koller <clemens.koller@anagramm.de> wrote:
> 
> > Well, sure, it's not a notebook HDD, but maybe it's possible
> > to give headpark a more generic way to get the heads parked?
> 
> I remember my old MFM HDD, which had a Landing Zone stored in the BIOS to
> which the park command would seek. Maybe you could do something similar
> and park the head on the last cylinder if the other options fail.
 
This is not really a good idea. It worked for the old drives, because
you weren't supposed to move them around.

The shock when the machine hits the ground will cause the head to move
anyway and bounce across the whole surface.

Real parking makes a click because the head is moved outside the surface
and locked in that position.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

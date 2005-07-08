Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVGHG1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVGHG1H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVGHG1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:27:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23000 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262635AbVGHGZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:25:53 -0400
Date: Fri, 8 Jul 2005 08:27:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: 7eggert@gmx.de, Clemens Koller <clemens.koller@anagramm.de>,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up
Message-ID: <20050708062720.GO24401@suse.de>
References: <4mtza-1vg-15@gated-at.bofh.it> <4mtII-1Ab-13@gated-at.bofh.it> <4mtSm-1FA-5@gated-at.bofh.it> <4mtSn-1FA-11@gated-at.bofh.it> <4mwx1-3N9-25@gated-at.bofh.it> <4mx9A-4qm-1@gated-at.bofh.it> <4nzCr-6fN-19@gated-at.bofh.it> <4nI36-527-9@gated-at.bofh.it> <E1DqhA2-000200-15@be1.7eggert.dyndns.org> <42CDCCCC.9050309@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CDCCCC.9050309@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Alejandro Bonilla wrote:
> Bodo Eggert wrote:
> 
> >Clemens Koller <clemens.koller@anagramm.de> wrote:
> >
> > 
> >
> >>Well, sure, it's not a notebook HDD, but maybe it's possible
> >>to give headpark a more generic way to get the heads parked?
> >>   
> >>
> >
> >I remember my old MFM HDD, which had a Landing Zone stored in the BIOS to
> >which the park command would seek. Maybe you could do something similar
> >and park the head on the last cylinder if the other options fail.
> > 
> >
> This makes me wonder... If you replace the internal HD with a non IBM or 
> IBM supported Hard Drive, will it still park the head and will it 
> support all the stuff?

Depends, the drive must support the IDLE_IMMEDIATE unload subfeature, as
described in ata7.

-- 
Jens Axboe


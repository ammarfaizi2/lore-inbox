Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVGHGZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVGHGZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVGHGZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:25:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61143 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262632AbVGHGZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:25:22 -0400
Date: Fri, 8 Jul 2005 08:26:35 +0200
From: Jens Axboe <axboe@suse.de>
To: 7eggert@gmx.de
Cc: Clemens Koller <clemens.koller@anagramm.de>,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]  IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050708062630.GN24401@suse.de>
References: <4msWl-Yq-5@gated-at.bofh.it> <4mtza-1vg-15@gated-at.bofh.it> <4mtII-1Ab-13@gated-at.bofh.it> <4mtSm-1FA-5@gated-at.bofh.it> <4mtSn-1FA-11@gated-at.bofh.it> <4mwx1-3N9-25@gated-at.bofh.it> <4mx9A-4qm-1@gated-at.bofh.it> <4nzCr-6fN-19@gated-at.bofh.it> <4nI36-527-9@gated-at.bofh.it> <E1DqhA2-000200-15@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DqhA2-000200-15@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08 2005, Bodo Eggert wrote:
> Clemens Koller <clemens.koller@anagramm.de> wrote:
> 
> > Well, sure, it's not a notebook HDD, but maybe it's possible
> > to give headpark a more generic way to get the heads parked?
> 
> I remember my old MFM HDD, which had a Landing Zone stored in the BIOS to
> which the park command would seek. Maybe you could do something similar
> and park the head on the last cylinder if the other options fail.

Yeah, in ancient times you would simply issue a SEEK to the landing zone
and the drive would park. Those days are long gone.

The SEEK is just a hint anyways, with the sophisticated caching that
drives do today I wouldn't rely on it doing anything reliable.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbUCNOon (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 09:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbUCNOom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 09:44:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35036 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263371AbUCNOol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 09:44:41 -0500
Date: Sun, 14 Mar 2004 15:44:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.4] IDE performance drop again
Message-ID: <20040314144433.GK6955@suse.de>
References: <20040314115727.GA21362@sun1000.pwr.wroc.pl> <c31iup$r2f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c31iup$r2f$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14 2004, Sven Köhler wrote:
> >hdparm /dev/hda
> >
> >/dev/hda:
> > multcount    =  1 (on)
> 
> This should be 16 if you've got a modern harddisk
> use -m 16 instead of -m 1

Doesn't matter, because:

> > using_dma    =  1 (on)

dma is on.

-- 
Jens Axboe


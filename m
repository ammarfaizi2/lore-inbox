Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269169AbTGJKNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269170AbTGJKNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:13:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1695 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269169AbTGJKM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:12:59 -0400
Date: Thu, 10 Jul 2003 12:26:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: "'Alan Shih'" <alan@storlinksemi.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Question regarding DMA xfer to user space directly
Message-ID: <20030710102655.GN825@suse.de>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB034C5623@mailse01.axis.se> <3C6BEE8B5E1BAC42905A93F13004E8AB03277A7C@mailse01.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB03277A7C@mailse01.axis.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10 2003, Mikael Starvik wrote:
> Hi,
> 
> Use map_user_kiobuf to do this. There are several examples
> in the kernel tree. One of the simplest may be 
> arch/cris/drivers/examples/kiobuftest.c.

get_user_pages() is a much better idea, considering 2.5/6 has no concept
of kiobufs.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVE3GFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVE3GFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 02:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVE3GFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 02:05:10 -0400
Received: from brick.kernel.dk ([62.242.22.158]:54659 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261536AbVE3GE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 02:04:58 -0400
Date: Mon, 30 May 2005 08:05:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michael Thonke <iogl64nx@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050530060556.GC7054@suse.de>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com> <20050529190259.GA29770@suse.de> <429A2238.8010604@gmail.com> <429A236D.8030307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429A236D.8030307@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29 2005, Jeff Garzik wrote:
> Michael Thonke wrote:
> >Well the subjective feeling is great through! What I noticed is a
> >improvement on rsync (goes slighty faster drive to drive).
> >The noise decrease now it only make noise on very heavy IO reads and 
> >writes.
> 
> 
> It might be as simple as...  NCQ means the drive is doing more work. 
> More work means more noise.

You can argue both ways :-). Usually more noise means more seeks and
thus less work done.

-- 
Jens Axboe


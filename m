Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbTGUMTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269968AbTGUMTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:19:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22497 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269967AbTGUMTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:19:31 -0400
Date: Mon, 21 Jul 2003 14:33:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi in 2.6.0 ?
Message-ID: <20030721123328.GD10781@suse.de>
References: <20030718162156.GA2946@gentoo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718162156.GA2946@gentoo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18 2003, Stephane Wirtel wrote:
> Hi 
> 
> I have a problem with ide-scsi
> 
> i put ide-scsi=/dev/hdc  in the "append"  of my grub configuration.
> 
> but, with dmesg, i can see, that i have a problem with this argument,
> because the kernel tells me, than it's a bad option.
> 
> my error : ide_setup: ide-scsi=/dev/hdc -- BAD OPTION

better question is why you want ide-scsi? it's broken, it's bad for your
health. doesn't recording work with -dev=/dev/hdc in cdrecord? it's way
faster and better for your karma.

-- 
Jens Axboe


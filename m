Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVCJQar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVCJQar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVCJQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:30:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56985 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262716AbVCJQ3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:29:24 -0500
Date: Thu, 10 Mar 2005 17:29:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: current linus bk, error mounting root
Message-ID: <20050310162918.GD2578@suse.de>
References: <20050309210926.GZ28855@suse.de> <9e473391050309171643733a12@mail.gmail.com> <20050310075049.GA30243@suse.de> <9e4733910503100658ff440e3@mail.gmail.com> <20050310153151.GY2578@suse.de> <9e473391050310074556aad6b0@mail.gmail.com> <20050310154830.GB2578@suse.de> <9e47339105031007595b1e0cc3@mail.gmail.com> <20050310160155.GC2578@suse.de> <9e4733910503100818df5fb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910503100818df5fb2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10 2005, Jon Smirl wrote:
> On Thu, 10 Mar 2005 17:01:55 +0100, Jens Axboe <axboe@suse.de> wrote:
> > what are the major/minor numbers of /dev/root?
> 
> 
> If I boot on a working system it is 8,5

I see no /dev/sda detected in your system from the dmesg. Ahh this is
where it panics on loading ata_piix I suppose, can't you capture that
panic with the serial console as well?

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVCJHvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVCJHvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 02:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVCJHvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 02:51:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12675 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262130AbVCJHvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 02:51:02 -0500
Date: Thu, 10 Mar 2005 08:50:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: current linus bk, error mounting root
Message-ID: <20050310075049.GA30243@suse.de>
References: <9e47339105030909031486744f@mail.gmail.com> <422F2F7C.3010605@pobox.com> <9e4733910503091023474eb377@mail.gmail.com> <422F5D0E.7020004@pobox.com> <9e473391050309125118f2e979@mail.gmail.com> <20050309210926.GZ28855@suse.de> <9e473391050309171643733a12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050309171643733a12@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09 2005, Jon Smirl wrote:
> On Wed, 9 Mar 2005 22:09:26 +0100, Jens Axboe <axboe@suse.de> wrote:
> > probably not worth the bother, looks like barrier problems. get the
> > serial console running instead and send the full output, I'll take a
> > look in the morning.
> 
> serial console boot output attached.

Hmm ok, nothing of interest there. What does the mount error 6 and 2
from  your original mail mean? I need some more info on what fails
specifically. What mount options are used? What partition is mounted (is
it md or hdaX)?

I'm not sure -bk5 had the follow up fix patch for the barrier rework,
you should probably just retry with -bk6 first.

-- 
Jens Axboe


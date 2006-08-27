Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWH0JSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWH0JSr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWH0JSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:18:47 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:53925 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1751354AbWH0JSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:18:47 -0400
Date: Sun, 27 Aug 2006 11:17:42 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.11
Message-ID: <20060827091742.GA6067@aepfle.de>
References: <20060823213108.GA12308@kroah.com> <20060823213130.GB12308@kroah.com> <20060824062943.GA11477@aepfle.de> <20060824071237.GA5577@suse.de> <20060824074041.GA12184@aepfle.de> <20060824075156.GA6457@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060824075156.GA6457@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, Greg KH wrote:

> > Yes, wrong place in the file, see http://lkml.org/lkml/2006/8/16/236
> 
> Ugh, how did patch go so wrong?

This one is weird. I'm sure I had tested the patch, but the above fails to
apply to 2.6.17. Its already in since 2.6.17-rc1.

> Anyway, care to send me a patch that I can use for the next -stable
> release that fixes this up?

Everything is fine.
Maybe revert 9df256a6742e951aef286bd8ffc859dd79509ad7,
drivers/serial/mpc52xx_uart.c does not use request_firmware().

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWEKPWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWEKPWs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWEKPWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:22:48 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:17750 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030259AbWEKPWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:22:47 -0400
Date: Thu, 11 May 2006 17:22:46 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Mark Hedges <hedges@ucsd.edu>
Cc: David Rees <drees76@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: unknown io writes in 2.6.16
Message-ID: <20060511152245.GE3755@harddisk-recovery.com>
References: <20060510135100.F26270@network.ucsd.edu> <72dbd3150605101442o52a62d79va730314bf96dcfdd@mail.gmail.com> <20060510225112.T31828@network.ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510225112.T31828@network.ucsd.edu>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 10:54:43PM -0700, Mark Hedges wrote:
> Just a wishlist that process IO could be monitored.  I hate to 
> say it but ctl-alt-esc in W2K can monitor io by process, and 
> that's really useful.  (I will never go back though.)

IIRC this can be done with Jens Axboe's blktrace. It got merged in
2.6.17, enable CONFIG_BLK_DEV_IO_TRACE and get the blktrace userspace
tools from git://brick.kernel.dk/data/git/blktrace.git .


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

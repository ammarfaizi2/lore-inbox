Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263172AbUKTUUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbUKTUUf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 15:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUKTUUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 15:20:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29156 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263173AbUKTUUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 15:20:21 -0500
Date: Sat, 20 Nov 2004 21:19:45 +0100
From: Jens Axboe <axboe@suse.de>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Message-ID: <20041120201944.GA26240@suse.de>
References: <20041120161704.GA14743@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041120161704.GA14743@hardeman.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20 2004, David Härdeman wrote:
> Hi,
> 
> currently my DVD player sounds like a jet plane when playing ordinary 
> audio CD's. I tried the different approaches to lowering playback speed 
> that are commonly used (hdparm, setspeed, etc) but none of them worked.
> 
> Then I found this thread:
> http://marc.theaimsgroup.com/?t=99366299900003&r=1&w=2
> 
> Which seems to indicate that DVD players need a different command 
> (SET_STREAMING), the thread is from 2001, and I've not been able to find 
> any more recent information.
> 
> So, my question is, is this implemented in the kernel and are there any 
> userspace tools to set the playback speed?

I don't know of any, but it is trival to write using SG_IO (or just
CDROM_SEND_PACKET for this simple use, since only a trivial amount of
data involved). If you are not sure how to do it, let me know and I can
easily write one in minutes.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVD1S5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVD1S5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVD1S5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:57:31 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:32660 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262223AbVD1S52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:57:28 -0400
Subject: Re: Extremely poor umass transfer rates
From: Mark Rosenstand <mark@bootless.dk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1114714032.8326.27.camel@mjollnir.bootless.dk>
References: <1114704142.8410.4.camel@mjollnir.bootless.dk>
	 <20050428165915.GG30768@redhat.com>
	 <1114710941.8326.13.camel@mjollnir.bootless.dk>
	 <20050428110614.00a0c193.rddunlap@osdl.org> <4271292F.1000002@grupopie.com>
	 <1114714032.8326.27.camel@mjollnir.bootless.dk>
Content-Type: text/plain
Organization: Bootless Enterprises
Date: Thu, 28 Apr 2005 20:57:49 +0200
Message-Id: <1114714669.8326.32.camel@mjollnir.bootless.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 20:47 +0200, Mark Rosenstand wrote:
> > Try mounting the device as root somewhere else without the "sync" flag 
> > and measure the performance that way, to see the difference.
> 
> Wow. That seems to speed things up alot. However I can't unmount it
> again, I keep getting "umount: /media/usbdisk: device is
> busy" (twice(?)). It's been 5 minutes since I did the transfer (4 MB
> file) now.

Err, I accidently mixed up the device names of my keyring and the mp3
player. It works allright.

(It flushes changes to the device when I unmount it now, which takes
around 8 seconds for a 4 MB file.)

Thanks a lot, Paulo!

-- 
  .-.    Mark Rosenstand        (-.)
  oo|                           cc )
 /`'\    (+45) 255 31337      3-n-(
(\_;/)   mark@geekworld.org    _(|/`->


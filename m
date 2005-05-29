Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVE2TEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVE2TEX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 15:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVE2TEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 15:04:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17548 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261347AbVE2TEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 15:04:07 -0400
Date: Sun, 29 May 2005 21:04:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <liml@rtr.ca>
Cc: Michael Thonke <iogl64nx@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050529190421.GB29770@suse.de>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com> <4299CD31.8020805@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4299CD31.8020805@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29 2005, Mark Lord wrote:
> My basic hdparm timing test shouldn't show much of a difference
> with NCQ tests, becase hdparm just does a single request at a time,
> and waits for the results before issuing another.  Now, kernel read-ahead
> may result in some command overlap and a slight throughput increase, but..
> 
> Something like dbench and/or bonnie++ are more appropriate here.

I don't like bonnie++ very much and dbench is very write intensive. I
would suggest trying tiotest, find it on sf.net. It gets easily readable
results and they are usually fairly consistent across runs if you limit
the RAM to something sensible (eg 256MB and using a data set size of
768MB).

-- 
Jens Axboe


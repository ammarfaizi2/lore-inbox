Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUDITwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 15:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUDITwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 15:52:04 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:40930 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261735AbUDITv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 15:51:59 -0400
Date: Fri, 9 Apr 2004 21:51:54 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: AM53C974 driver missing in 2.6.5
Message-ID: <20040409195153.GA2007@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200404091807.48179.info@roessner-net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404091807.48179.info@roessner-net.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Apr 2004, Christian Roessner wrote:

> I found at Google that the AM53C974 was removed since 2.6.0. My problem is: 
> This driver is the only one that ever worked (2.4 kernels) for my TEAC CD 
> writer. The tmscsim doesn?t do its job and that has nothing to do with the 
> latency thing with SCSI-2.

Why does tmscsim not do its job? What is the problem?
What brand and type is your host adaptor? (add lspci if possible)

> Is there a chance you could put the AM53C974 back in the kernel? Otherwise I 
> will not be able to burn CDs under linux anymore :-(

The AM53C974 driver was removed because it was unmaintained and broken,
it would have been a lot of work to a) fix the driver, b) port it to
2.6. tmscsim only required b).  Even if AM53C974 were put back and
ported to 2.6, it would still be broken.

If it was put back, it still wouldn't work.

I don't know who the official maintainer for tmscsim is now - Kurt
Garloff is still listed, but I wonder if he has time. Describing your
problem in detail on linux-scsi@ might be a good idea.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

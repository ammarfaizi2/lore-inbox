Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWC3Gnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWC3Gnw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWC3Gnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:43:50 -0500
Received: from colo.lackof.org ([198.49.126.79]:3746 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751145AbWC3Gnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:43:49 -0500
Date: Wed, 29 Mar 2006 23:54:55 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: "Ju, Seokmann" <Seokmann.Ju@engenio.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: I/O performance measurement tools on Linux
Message-ID: <20060330065455.GA31964@colo.lackof.org>
References: <890BF3111FB9484E9526987D912B261901BC88@NAMAIL3.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890BF3111FB9484E9526987D912B261901BC88@NAMAIL3.ad.lsil.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 10:53:14AM -0800, Ju, Seokmann wrote:
> Hi,
> 
> Are there any performance measurement tools available that running on
> Linux?
> I would like to measure disk I/O performance (file system and raw I/O)
> on several kernels.

iozone and bonnie are two well established benchmarks.
Multiple versions of diskbench (aka "db") are also good.
"spew" is a new kid on the block but easy to use.

Hrm...looks like debian dropped iozone from the next release.

> Please lead me to the place.

google is your friend. :)
google can lead to to all of the above if you don't have
debian (ie "apt-get install bonnie++ spew").

Note that having a bench marking tool is just half the battle.
Knowing _what_ the result means is the other half.


hth,
grant

> 
> Thank you,
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

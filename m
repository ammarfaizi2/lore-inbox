Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266453AbUGUOkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUGUOkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUGUOkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:40:13 -0400
Received: from [194.243.27.136] ([194.243.27.136]:1546 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S266453AbUGUOkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:40:06 -0400
X-Qmail-Scanner-Mail-From: devel@integra-sc.it via venere.pandoraonline.it
X-Qmail-Scanner-Rcpt-To: ahu@ds9a.nl,shesha@inostor.com,linux-kernel@vger.kernel.org,kernelnewbies@nl.linux.org
X-Qmail-Scanner: 1.22 (Clear:RC:1(213.140.22.76):. Processed in 0.16415 secs)
Date: Wed, 21 Jul 2004 16:45:10 +0200
From: Devel <devel@integra-sc.it>
To: bert hubert <ahu@ds9a.nl>
Cc: shesha@inostor.com, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: O_DIRECT
Message-Id: <20040721164510.3086b49f.devel@integra-sc.it>
In-Reply-To: <20040720184824.GA30090@outpost.ds9a.nl>
References: <40FD561D.1010404@inostor.com>
	<20040720184824.GA30090@outpost.ds9a.nl>
Organization: Integra Solutions
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
how i can write data on a partition without a filesystem??

Saluti Carlo!

Il Tue, 20 Jul 2004 20:48:24 +0200
bert hubert <ahu@ds9a.nl> scrisse:

> On Tue, Jul 20, 2004 at 10:27:57AM -0700, Shesha Sreenivasamurthy wrote:
> > I am having trouble with O_DIRECT. Trying to read or write from a block 
> > device partition.
> > 
> > 1. Can O_DIRECT be used on a plain block device partition say 
> > "/dev/sda11" without having a filesystem on it.
> 
> As fas as I know, yes, but be aware that O_DIRECT requires page aligned
> addresses! (an integral of 4096 on most systems).
> 
> > 2. If no file system is created then what should be the softblock size. 
> > I am using the IOCTL "BLKBSZGET". Is this correct?
> 
> No idea what you mean - but see above about the aligned addresses.
> 
> > 3. Can we use SEEK_END with O_DIRECT on a partition without filesystem.
> 
> I see no reason why not. Good luck!
> 
> -- 
> http://www.PowerDNS.com      Open source, database driven DNS Software 
> http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

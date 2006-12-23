Return-Path: <linux-kernel-owner+w=401wt.eu-S1753453AbWLWCQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbWLWCQX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 21:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbWLWCQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 21:16:23 -0500
Received: from userg504.nifty.com ([202.248.238.84]:17934 "EHLO
	userg504.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbWLWCQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 21:16:22 -0500
DomainKey-Signature: a=rsa-sha1; s=userg504; d=nifty.com; c=simple; q=dns;
	b=CXfd3811PyjGPgfgNqnabEXf58uZijxUFcNS/yoZbF00T8HUXmGNpD02M+yXgJnfh
	/VqMTzPwjPlxLB+e0sqRA==
Date: Sat, 23 Dec 2006 20:17:45 +0900
From: Komuro <komurojun-mbn@nifty.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, Al Viro <viro@ftp.linux.org.uk>,
       "netdev@vger.kernel.org;Adrian Bunk" <bunk@stusta.de>
Subject: Re: [BUG KERNEL 2.6.20-rc1]  ftp: get or put stops during
 file-transfer
Message-Id: <20061223201745.8bff64e3.komurojun-mbn@nifty.com>
In-Reply-To: <20061218030113.GT10316@stusta.de>
References: <20061217212752.d93816b4.komurojun-mbn@nifty.com>
	<20061217040222.GD17561@ftp.linux.org.uk>
	<20061217232311.f181302f.komurojun-mbn@nifty.com>
	<20061218030113.GT10316@stusta.de>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > On kernel 2.6.20-rc1, ftp (get or put) stops
> > during file-transfer.
> > 
> > Client: ftp-0.17-33.fc6  (192.168.1.1)
> > Server: vsftpd-2.0.5-8   (192.168.1.3)
> > 

This problem happens on kernel-2.6.19-git4 or later.
but does _not_ happen on kernel-2.6.19-git3.

So this problem is introduced to kernel-2.6.19-git4.


I tried the Marvell 88E8001(skge) and Realtek 8139(8139too),
the same problem happens.

I think this is not a network-card-driver problem.

Thanks!
 
Best Regards
Komuro
 

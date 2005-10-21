Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVJUVpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVJUVpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVJUVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:45:12 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:26521 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751266AbVJUVpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:45:10 -0400
Message-ID: <43596160.3080407@rtr.ca>
Date: Fri, 21 Oct 2005 17:45:04 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Merging ATA passthru
References: <43593E0A.4070801@pobox.com>
In-Reply-To: <43593E0A.4070801@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Folks,
> 
> Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
> the ATA passthru work upstream, once 2.6.14 is released.

Thanks, Jeff!

> Since there are still some reported problems that I haven't had time to 
> track down, I'm going to -- like ATAPI -- introduce a module option that 
> enables passthru.  It will default to off.

With passthru, it would really be much better to just leave it enabled
without any option.  It's NOT on any main code path, and users/distros
have to intentionally run "smartctl -d ata" or "hdparm /dev/sd*" to
trigger any of it.

So it is already "off", unless somebody wants to use it.
This is different from the ATAPI code.

But good to have it finally going upstream where it will get used.

Cheers!

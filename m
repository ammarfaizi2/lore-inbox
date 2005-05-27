Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVE0WSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVE0WSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVE0WSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:18:47 -0400
Received: from mail.dvmed.net ([216.237.124.58]:34273 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262631AbVE0WQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:16:53 -0400
Message-ID: <42979C4F.8020007@pobox.com>
Date: Fri, 27 May 2005 18:16:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com>
In-Reply-To: <429793C8.8090007@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> Hello Jens,
> 
> I tried to play with your patch on ICH6R and ICH7R chipset also on
> Sil3124R Controller
> with 2xSamsung HD160JJ SATAII drives. But the performance gain stay out..
> anything special to set to get it working? I used a vanilla-kernel
> 2.6.12-rc5-git2 for it.

SiI 3124 driver needs to be updated to support NCQ.

	Jeff




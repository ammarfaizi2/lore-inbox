Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272533AbTHKMqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272535AbTHKMqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:46:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17611 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272533AbTHKMqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:46:51 -0400
Message-ID: <3F37902F.8050502@pobox.com>
Date: Mon, 11 Aug 2003 08:46:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill HDIO_GETGEO_BIG_RAW ioctl
References: <Pine.LNX.4.10.10308110515510.12816-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10308110515510.12816-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 28bit it is a free for all, and anything goes in linux because nobody is
> willing to commit and force anything over 8.4GB to LBA only.  People think
> that "orphan sectors" are a bad thing.  IFF one can only IO in LBA with
> the exception of sectors at or below the 8.4GB limit then one never needs
> to worry about rogue programs existing out in nowhere land.


libata requires LBA support, and always uses LBA addressing <grin>

	Jeff




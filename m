Return-Path: <linux-kernel-owner+w=401wt.eu-S932431AbXAGIZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbXAGIZa (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 03:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbXAGIZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 03:25:30 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47698 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932431AbXAGIZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 03:25:30 -0500
Message-ID: <45A0AE76.40600@garzik.org>
Date: Sun, 07 Jan 2007 03:25:26 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Manish Regmi <regmi.manish@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ATA streaming feature support
References: <652016d30701062240w4756bc4m8fdb54070708fd81@mail.gmail.com>
In-Reply-To: <652016d30701062240w4756bc4m8fdb54070708fd81@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Regmi wrote:
> Hi all,
>   First of all sorry for bringing this topic again.
> As discussed in  --> http://lkml.org/lkml/2006/5/5/47
> The ATA Streaming feature set is not necessary to be in Kernel Space
> (IDE driver). There is a suggestion creating user space library.
> 
> But how is the user space apps going to use the commands like READ
> STREAM DMA EXT (0x2A). Shouldn't there be some support in kernel which
> setups up PRD tables  and all.
> It doesn't seem to be possible.... is it?

If you pass SG_IO addresses, they become DMA scatter/gather tables.

	Jeff




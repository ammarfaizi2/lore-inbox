Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUGMOm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUGMOm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUGMOm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:42:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50149 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265269AbUGMOlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:41:25 -0400
Message-ID: <40F3F482.7020105@pobox.com>
Date: Tue, 13 Jul 2004 10:41:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Leonard <ian@smallworld.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-rc3 sata ICH5R
References: <40F3BCD1.2090209@smallworld.cx>
In-Reply-To: <40F3BCD1.2090209@smallworld.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Leonard wrote:
> Hi,
> 
> I have an motherboard with an Intel 82801EB. The documentation claims it 
> has an Intel ICH5R sata interface.
> 
> With the previous kernel version I tried, it locked up when probing the 
> disks on boot. 2.4.27-rc3 boots but gives many errors on /dev/hdg. These 
> look something like:
> 
> hdg: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> 
> According to what I have read, this should be supported and should be 
> using /dev/hd? rather than /dev/sd?. Is this correct?

Incorrect, SATA is /dev/sd?.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVADCKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVADCKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 21:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVADCKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 21:10:46 -0500
Received: from terminus.zytor.com ([209.128.68.124]:46764 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261939AbVADCKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 21:10:40 -0500
Message-ID: <41D9FAF2.4000405@zytor.com>
Date: Mon, 03 Jan 2005 18:09:54 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
References: <41D9C635.1090703@zytor.com>	<16857.56805.501880.446082@samba.org>	<41D9E3AA.5050903@zytor.com>	<16857.59946.683684.231658@samba.org>	<41D9EDF6.1060600@zytor.com>	<16857.62250.259275.305392@samba.org>	<41D9F65E.3030301@zytor.com> <16857.63978.65838.823252@samba.org>
In-Reply-To: <16857.63978.65838.823252@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
> 
> right. Samba doesn't care much about VFAT, and you don't care about
> all the other attributes, so we should get along fine without treading
> on each others toes too much.
> 
> I explained what Samba4 does as you asked about the user.DosAttrib
> xattr that Steve put a placeholder for in cifsfs. That came from
> Samba4, so if you suddenly started using it in a different way I would
> get a sore toe :-)
> 
> Once the Samba LSM module is done and Wine and Samba start working
> more together on all these extra bits of meta-data then we could
> consider making your ioctl work on all filesystems when the LSM module
> is loaded.
> 

Sounds reasonable.

	-hpa


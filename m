Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVLFJGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVLFJGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 04:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVLFJGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 04:06:50 -0500
Received: from mail.dvmed.net ([216.237.124.58]:31635 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964810AbVLFJGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 04:06:48 -0500
Message-ID: <439554A3.7000305@pobox.com>
Date: Tue, 06 Dec 2005 04:06:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Backlund <tmb@mandriva.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] sata_sil: greatly improve DMA handling
References: <20051203200438.GA3770@havoc.gtf.org> <dn297e$aip$1@sea.gmane.org>
In-Reply-To: <dn297e$aip$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Thomas Backlund wrote: > Jeff Garzik wrote: > > >>To
	make it easy for others to test, since there are merge conflicts,
	>>I've combined the two previous sata_sil patches into a single patch.
	>> >>Verified here on my 3112 (Adaptec 1210SA). >> >>I'm especially
	interested to hear from anyone willing to test on a >>SI 3114 (4-port).
	>> >> > > > Please cc me as I'm not subscribed.... > > > ASUS
	K8N-E-Deluxe, nForce3 250Gb chipset, AMD Athlon64 3200+ running x86_64
	> > Sil 3114A with 3 Maxtor MaxLine III+ 250GBSATA disks running in
	linux raid1, > linux raid0 and linux LVM2 > > Boots and runs without
	problem with 2.6.15-rc5-git1, > > Applying this patch lets it boot, but
	I cant login either locally or with > ssh, no output on VT12 or in the
	logs, but the hd led is lit all the > time... [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Backlund wrote:
> Jeff Garzik wrote:
> 
> 
>>To make it easy for others to test, since there are merge conflicts,
>>I've combined the two previous sata_sil patches into a single patch.
>>
>>Verified here on my 3112 (Adaptec 1210SA).
>>
>>I'm especially interested to hear from anyone willing to test on a
>>SI 3114 (4-port).
>>
>>
> 
> 
> Please cc me as I'm not subscribed....
> 
> 
> ASUS K8N-E-Deluxe, nForce3 250Gb chipset, AMD Athlon64 3200+ running x86_64
> 
> Sil 3114A with 3 Maxtor MaxLine III+ 250GBSATA disks running in linux raid1,
> linux raid0 and linux LVM2
> 
> Boots and runs without problem with 2.6.15-rc5-git1,
> 
> Applying this patch lets it boot, but I cant login either locally or with
> ssh, no output on VT12 or in the logs, but the hd led is lit all the
> time...

Thanks for testing.


> only way to reboot is the reset button...
> 
> 
> Distribution is Mandriva Linux 2006 x86_64, gcc 4.0.1
> 
> attached are config and /var/log/messages parts that got logged

Didn't receive any attachments...

	Jeff



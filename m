Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbWHNSG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbWHNSG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWHNSG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:06:28 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:53858 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932651AbWHNSG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:06:27 -0400
Message-ID: <44E0BBAD.4080007@cfl.rr.com>
Date: Mon, 14 Aug 2006 14:06:37 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
CC: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       darkhack@gmail.com
Subject: Re: kernel panic - not syncing: VFS - unable to mount root fs on
 unknown-block
References: <44DFCF20.9030202@wanadoo.fr> <44E07B36.6070508@gmail.com> <44E08C50.5070904@wanadoo.fr>
In-Reply-To: <44E08C50.5070904@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Aug 2006 18:06:39.0125 (UTC) FILETIME=[638FF450:01C6BFCC]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14628.003
X-TM-AS-Result: No--3.700000-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to use the initrd.  See the man pages for update-initramfs and 
maybe mkinitramfs.  The initrd is where all the drivers get loaded and 
hardware is detected in an Ubuntu system.  It is required for root to be 
on LVM.

Hulin Thibaud wrote:
> Sorry, new kernel is 2.6.17. to install suspend2.
> I believe using LVM, but I'm not sure.
> In effect, initrd is not present ! I rode this lines in my menu.lst :
> title        Ubuntu, kernel 2.6.171915
> root        (hd1,4)
> kernel        /boot/vmlinuz-2.6.171915 root=/dev/hdb5 ro quiet splash
> savedefault
> boot
> 
> So, I suppose that's the center of the problem, but actually, I don't 
> know how to solve it.
> 


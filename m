Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVBQVu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVBQVu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 16:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVBQVu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 16:50:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3281 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261201AbVBQVuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 16:50:21 -0500
Message-ID: <4215118D.3020902@pobox.com>
Date: Thu, 17 Feb 2005 16:50:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik van Konijnenburg <ekonijn@xs4all.nl>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] yaird, a mkinitrd based on hotplug concepts
References: <20050217210620.A20645@banaan.localdomain>
In-Reply-To: <20050217210620.A20645@banaan.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik van Konijnenburg wrote:
> Features:
>  - handles both initrd and initramfs.


Comments:

* Having a mkinitrd that's not a shell script is a godsend.  I would 
endorse yaird on that fact alone :)

* I've long wanted a "mkinitfoo" that would create .cpio.gz for 
initramfs by default.  So, good job there, too.

* Eventually your script will need pull in, into the initramfs, klibc 
and programs linked against klibc.

	Jeff



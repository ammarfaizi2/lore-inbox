Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVCCCep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVCCCep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVCCC0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:26:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27087 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261418AbVCCCX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:23:57 -0500
Message-ID: <42267526.4000102@pobox.com>
Date: Wed, 02 Mar 2005 21:23:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Damian Kolkowski <damian@kolkowski.no-ip.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] - SATA / ioctl(). (HDIO_GET_IDENTITY failed...)
References: <20050303015341.GENTOO-LINUX-ROX.B8468@kolkowski.no-ip.org>
In-Reply-To: <20050303015341.GENTOO-LINUX-ROX.B8468@kolkowski.no-ip.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damian Kolkowski wrote:
> Hi,
> 
> Is there any patch to correct libata working with ioctl()?

libata works fine with ioctl(2).


> For example:
> 
> .~. # hdparm -t /dev/hda /dev/sda
> /dev/hda:
>  Timing buffered disk reads:  174 MB in  3.03 seconds =  57.36 MB/sec
> /dev/sda:
>  Timing buffered disk reads:  152 MB in  3.03 seconds =  50.11 MB/sec
> HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
> .~. #
> 
> I can attach addition: dmesg, kernel.config, lspci, etc...

Arbitrary command execution is only supported in libata-dev tree for now.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTGBJeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTGBJeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:34:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49059 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264873AbTGBJdy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:33:54 -0400
Message-ID: <3F02AA4B.2040209@pobox.com>
Date: Wed, 02 Jul 2003 05:47:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Mock <jeff-ml@mock.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
References: <5.1.0.14.2.20030701114153.060dd098@mail.mock.com> <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com> <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com> <5.1.0.14.2.20030701114153.060dd098@mail.mock.com> <5.1.0.14.2.20030702002400.060d8658@mail.mock.com>
In-Reply-To: <5.1.0.14.2.20030702002400.060d8658@mail.mock.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mock wrote:
> Wow, that's great, it works really well.  I'm doing a software raid-0
> across the two sata drives, I've been stressing it all afternoon with
> no problems.

Thanks!

I've been meaning to convert my main SATA test box over to softraid-0 
running ext2.  Man, I bet that thing will go fast...


> To see the CONFIG_SCSI_ATA_* options during configuration I had to set
> CONFIG_SCSI=y  (I had it set to CONFIG_SCSI=m previously.)  Also, if
> you want to boot from the SATA drives you should also set
> CONFIG_BLK_DEV_SD=y, or maybe load the module from initrd.

Yep, good point.

FWIW, loading the module(s) from initrd works too.


> I enjoy having the drives called /dev/sd[ab], it makes me feel like I
> paid more money for them.

chuckle.

	Jeff




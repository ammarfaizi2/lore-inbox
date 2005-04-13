Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVDMRvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVDMRvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 13:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDMRvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 13:51:22 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:22244 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S261171AbVDMRvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 13:51:17 -0400
Message-ID: <425D5CCE.1050703@shadowconnect.com>
Date: Wed, 13 Apr 2005 19:54:22 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 2010S i2o + x86_64 doesn't work
References: <20050413160352.GA12841@xs4all.net>
In-Reply-To: <20050413160352.GA12841@xs4all.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Miquel van Smoorenburg wrote:
> I have a supermicro dual xeon em64t system, X6DH8-XG2 motherboard,
> 4 GB RAM, with an Adaptec zero raid 2010S i2o controller. In 32
> bits mode it runs fine, both with the dpt_i2o driver and the
> generic i2o_block driver using kernel 2.6.11.6.
> In 64 bits mode however the dpt_i2o driver isn't supported, so
> you have to use the generic i2o layer. But that doesn't work
> either - sometimes when booting the partition table is detected,
> sometimes it isn't. If it isn't, then fdisk /dev/i2o/hda works
> but shows an empty disk (while there definitely are partitions
> present)
> In both cases doing a dd if=/dev/i2o/hda of=/dev/null crashes
> the system.
> According to http://i2o.shadowconnect.com/ , it should work.
> I've upgraded the BIOS and firmware of the mobo and controller to
> the latest versions - doesn't help. Can someone suggest what to
> try next ?

Could you try out the 2.6.9 kernel, because i know that this one is working?

Also could you send me a complete output of dmesg?


Thank you very much.



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

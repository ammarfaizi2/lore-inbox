Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUJORK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUJORK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUJORK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:10:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268285AbUJORJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:09:25 -0400
Message-ID: <41700439.8080809@pobox.com>
Date: Fri, 15 Oct 2004 13:09:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: a.ledvinka@promon.cz
CC: linux-kernel@vger.kernel.org
Subject: Re: promise (105a:3319) unattended boot
References: <OF77D5B4E1.A38CC6EC-ONC1256F2E.004E78A5-C1256F2E.0050B72C@promon.cz>
In-Reply-To: <OF77D5B4E1.A38CC6EC-ONC1256F2E.004E78A5-C1256F2E.0050B72C@promon.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a.ledvinka@promon.cz wrote:
> Hello.
> 
> Got here http://pciids.sourceforge.net/iii/?i=105a3319
> As http://linux.yyz.us/sata/faq-sata-raid.html#tx4 calls it 
> soft/accelerator raid version
> Going to use latest kernel from /pub/linux/kernel/v2.4/
> 
> But bios even with keyboard unplugged requires me to press one of 2 keys 
> to either define array OR continue booting in case no array is defined.
> 
> What would you recommend me to do?
> - stay with ft3xx module from promise  and 10 level RAID array and not use 
> sata_promise?
> - define some array in bios and completely ignore that fact and use 
> sata_promise, bypass bios and define custom linux soft raid arrays?
> - anything else (no bios flashing and no hw hacking)?

You can use dmraid or ataraid, and define a JBOD array consisting of one 
disk in each array (i.e. one JBOD per disk)

	Jeff




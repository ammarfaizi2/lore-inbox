Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbULPROx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbULPROx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbULPROi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:14:38 -0500
Received: from neopsis.com ([213.239.204.14]:49890 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S261947AbULPRNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:13:00 -0500
Message-ID: <41C1C2AD.90902@dbservice.com>
Date: Thu, 16 Dec 2004 18:15:25 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Conway <nconway_kernel@yahoo.co.uk>
Cc: Hans Kristian Rosbach <hk@isphuset.no>,
       Mark Watts <m.watts@eris.qinetiq.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 3TB disk hassles
References: <20041216164413.71455.qmail@web26506.mail.ukl.yahoo.com>
In-Reply-To: <20041216164413.71455.qmail@web26506.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Conway wrote:
  > Right now, the only scheme I have vaguely concocted in my head that
> will make this work for us is to add another disk to become the boot
> disk - this is actually a major PITA cos there's really no physical
> space in the chassis - and then use a GPT/EFI (whatever?) partition
> table on the big disk.  This means that BIOS won't understand the big
> disk at all but that'll be OK since it isn't trying to boot from it.
> 
> Anyone with a magic tip for how to do this is welcome to tell us all
> ;-))
> 

I had a GUID partition table (GPT) on my system (x86, normal 
mainboard/BIOS etc) and it worked fine. I didn't need a separate boot 
disk. I used grub as the boot loader. I think if you enable GPT in the 
kernel you should be able to boot stright from the big disk.

tom

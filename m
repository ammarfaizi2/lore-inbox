Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVCUG75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVCUG75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 01:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVCUG75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 01:59:57 -0500
Received: from wasp.net.au ([203.190.192.17]:20641 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261598AbVCUG7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 01:59:46 -0500
Message-ID: <423E70D7.8060707@wasp.net.au>
Date: Mon, 21 Mar 2005 10:59:35 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Whelchel <koyama@firstlight.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA Promise TX4 Crash
References: <Pine.LNX.4.44.0503201555580.12407-100000@kishna.firstlight.net>
In-Reply-To: <Pine.LNX.4.44.0503201555580.12407-100000@kishna.firstlight.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Whelchel wrote:
> Hello,
> I have two Promise SATA TX4 cards connected to a total of 6 Maxtor 250 GB
> drives (7Y250M0) configured into a RAID 5. All works well with small
> disk load, but when a large number of requests are issued, it causes crash
> similar to the attached, except that the errors before the crash are on a

> EFLAGS: 00010046   (2.6.11.2)
> EIP is at scsi_put_command+0xbb/0x100

Oooh Oooh Oooh, pick me Mr Kotter!
I have seen this repeatedly, fought it and "apparently" beat it by upgrading my PSU.
I could reliably reproduce it by running a raid resync and issuing SMART queries
to the drives, but after a PSU upgrade it has gone away.
I have tried hard to reproduce it recently but I just can't get it to crash anymore.

I have a similar setup 4x SATA-TX4 cards and 15x 7Y250M0 drives. I'm thought it was actually
a bug, but as I can't reproduce it anymore it's making it a bit hard to track down.

Not much help, sorry.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams

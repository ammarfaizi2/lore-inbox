Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbUCZAIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbUCZAIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:08:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57812 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263842AbUCZABZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:01:25 -0500
Message-ID: <406372C5.600@pobox.com>
Date: Thu, 25 Mar 2004 19:01:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org, Kevin Corry <kevcorry@us.ibm.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com> <40632994.7080504@pobox.com> <1035780000.1080258411@aslan.btc.adaptec.com>
In-Reply-To: <1035780000.1080258411@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:
>>Jeff Garzik wrote:
>>
>>Just so there is no confusion...  the "failing over...in userland" thing I
>>mention is _only_ during discovery of the root disk.
> 
> 
> None of the solutions being talked about perform "failing over" in
> userland.  The RAID transforms which perform this operation are kernel
> resident in DM, MD, and EMD.  Perhaps you are talking about spare
> activation and rebuild?

This is precisely why I sent the second email, and made the 
qualification I did :)

For a "do it in userland" solution, an initrd or initramfs piece 
examines the system configuration, and assembles physical disks into 
RAID arrays based on the information it finds.  I was mainly implying 
that an initrd solution would have to provide some primitive failover 
initially, before the kernel is bootstrapped...  much like a bootloader 
that supports booting off a RAID1 array would need to do.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUATS0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbUATS0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:26:08 -0500
Received: from imap.gmx.net ([213.165.64.20]:23019 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265654AbUATS0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:26:04 -0500
X-Authenticated: #7370606
Message-ID: <400D72B5.40705@gmx.at>
Date: Tue, 20 Jan 2004 19:25:57 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HPT370 status [2.4/2.6]
References: <1g0ZG-2q6-15@gated-at.bofh.it>
In-Reply-To: <1g0ZG-2q6-15@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:
> Hello List,
> 
> Before I start frying my disks and all, what's the usability status of the 
> Hightpoint HPT370 ide "raid" controller on linux 2.4 and 2.6?

2.4 is fine if you use the ataraid code. mirroring is not fault tolerant 
so you would not want to use that. raid-0 and jbod is ok. i am currently 
looking into 2.6. i will probably write an evms plugin for the new 
kernel. the nice thing is that it will work also for 2.4er kernels with 
the evms patches plus we get a proper mirroring solution for free. :)

bye,
wilfried

> 
> Is there any release that actually supports the "half hard half software" 
> stripe that can be created with the bios of these things?
> 
> I've got one on my mobo (Abit KG7-Raid) and I'm in dire need of extra 
> controllers ;p If the raid would work, would be nice, but is not required.
> 
> [linux-ide answers: please CC me since I'm not on _that_ list]
> 
> Jan


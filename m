Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271271AbUJVOlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271271AbUJVOlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271068AbUJVOlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:41:24 -0400
Received: from magic.adaptec.com ([216.52.22.17]:55532 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S271271AbUJVOku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:40:50 -0400
Message-ID: <41791BE6.7040209@adaptec.com>
Date: Fri, 22 Oct 2004 10:40:38 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "K.R. Foley" <kr@cybsft.com>, "J.A. Magallon" <jamagallon@able.es>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
References: <1097178019.24355.39.camel@localhost> <1097188963l.6408l.2l@werewolf.able.es> <41661013.9090700@cybsft.com> <41668346.6090109@adaptec.com> <20041022135800.GA8254@elte.hu> <41791302.5030305@adaptec.com> <20041022140701.GC8120@elte.hu>
In-Reply-To: <20041022140701.GC8120@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2004 14:40:48.0570 (UTC) FILETIME=[1F0211A0:01C4B845]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Luben Tuikov <luben_tuikov@adaptec.com> wrote:
> 
> 
>>Have you tried this with the latest scsi-misc-2.6 tree?  The PCI table
>>patches are there.
>>
>>If you have _and_ it still does not work, can you send output of
>>"lspci -vn"?
> 
> 
> no, i havent. Is it easy to apply that tree to 2.6.9-rc4-mm1?

Yes, I think so.  There's 2 patches there for the AIC drivers:
the PCI tables and sleeping while holding a lock.

	Luben



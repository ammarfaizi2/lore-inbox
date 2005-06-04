Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVFDTGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVFDTGR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 15:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVFDTGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 15:06:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:47810 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261419AbVFDTGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 15:06:07 -0400
Message-ID: <42A1FB91.5060702@pobox.com>
Date: Sat, 04 Jun 2005 15:05:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Greg Stark <gsstark@mit.edu>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com> <42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de>
In-Reply-To: <20050604185028.GZ4992@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Jun 04, 2005 at 01:48:28PM -0400, Jeff Garzik wrote:
> 
>>Greg Stark wrote:
>>
>>>Jeff Garzik <jgarzik@pobox.com> writes:
>>>
>>>
>>>
>>>>Several updates to the libata-dev.git repository.  Some of the branches 
>>>>have
>>>>been folded into a new upstream-2.6.13 branch, which holds several 
>>>>changes (see
>>>>attached).  Other branches were updated to the most recent kernel, which
>>>>contained doc updates that caused some minor merge conflicts.
>>>>
>>>>I haven't yet updated 'passthru' and 'chs-support' branches to the latest
>>>>kernel.
>>>>
>>>>Git Repository URL:
>>>>rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>>>
>>>>List of branches:
>>>>adma          chs-support  master    pdc2027x           sleeping-eh
>>>>adma-mwi      iomap        ncq       promise-sata-pata  upstream-2.6.13
>>>>atapi-enable  iomap-step1  passthru  sil24
>>>
>>>
>>>Are there diffs downloadable for these? In particular I'm looking for
>>>passthru. I'm imagining that with passthru SMART works?
>>
>>You'll need to generate the diffs yourself, I'm afraid.
> 
> 
> I haven't tried git, but is there really no way to tell git to do
> "For every branch, generate a diff against Linus' tree" ?

for branch in .git/refs/heads/*
do
	...
done


> This together with making them available at some URL would make life 
> easier for some people.

And you, or anyone else, is welcome to take on this past and create a 
website that auto-posts patches for trees.

All my development is in public; all the data is there for anyone who 
wishes to use it.

	Jeff



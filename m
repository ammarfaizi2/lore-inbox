Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbTHVU1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 16:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTHVU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 16:27:09 -0400
Received: from vsmtp3.tin.it ([212.216.176.223]:7381 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S263402AbTHVU1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 16:27:03 -0400
Message-ID: <3F468ABD.1EBAD831@tin.it>
Date: Fri, 22 Aug 2003 21:27:25 +0000
From: "A.D.F." <adefacc@tin.it>
Reply-To: adefacc@tin.it
Organization: Private
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.2.24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-2.2 future?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday 20 August 2003 14:3, Ruben Puettman wrote:
>> On Wednesday 20 August 2003 13:59, Marc-Christian Petersen wrote:
>> 
>> Hi Alan,
>> 
>>> On Wednesday 20 August 2003 13:46, Alan Cox wrote:
>>> he 2.2 tree needs a new maintainer, someone who can spend their entire
>>> life refusing patches, being ignored by the mainstream (because 2.2 is
>>> boring) and by vendors (who don't ship 2.2 any more). 
>> 
>> I want to take 2.2.
>>
> What's up with linux-2.2 now? Who will do Alan's job in the next year?
>
> Marc is intrested doing this job. I know Marc from linux-2.2.x-secure
> and from the wolk project, see http://wolk.sourceforge.net. Why not
> Marc? He can surely differentiate between mainstream and a private kernel fork
> tree. Or do you think, Marc will merge every single bit out of his kernel tree
> into mainstream? I bet he won't 
>
> I can't see postings from other people who want to take 2.2.
>
> I think 2.2 is not dead. I often see 2.2 kernels running on systems like
> wlan access points or dsl routers from different vendors. 2.2 is often
> used where stability is a must-have. At least security fixes have to go in.

I agree.

> What do you think?

Well, I think that 2.2.24 and 2.2.25 kernels are really stable (at least on
UP), but that the most weak side is on IDE disk drivers.

They seem to have DMA problems when using recent hard disks (i.e. Maxtor,
etc.)
that lead to serious file system corruption problems.

Maybe there are also geometry problems because all troubles have been
observed
on disks with more than 32 GB of capacity (i.e. 40 GB).

This is a pity because, up to now, 2.2.x kernels have been
a valid choice for small / semi-embedded systems 80x86
(yes, I know that 2.4 should be better, but I'm still waiting for
 a stable rock kernel).

In conclusion, I hope that next maintainer will think about
these matters:
	IDE drivers;
	security fixes;
	micro-optimizations;
	compatibility with newer compilers.

After all if 2.0 seems to be still alive also 2.2 should be.

		A. De Faccio

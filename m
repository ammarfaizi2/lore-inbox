Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbTHSO3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270496AbTHSO3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:29:06 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:45762 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S270487AbTHSO3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:29:00 -0400
Message-ID: <3F42342A.8050605@verizon.net>
Date: Tue, 19 Aug 2003 10:28:58 -0400
From: "Anthony R." <russo.lutions@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: cache limit
References: <3F41AA15.1020802@verizon.net> <200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [162.84.223.61] at Tue, 19 Aug 2003 09:28:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>another program needs more memory, so it shouldn't swap, but that is not
>>the
>>behaviour I am seeing.
>>
>>Can anyone help point me in the right direction?
>>    
>>
>
>I'd say stop allocating insane amounts of swap.
>Frankly, with 2G you may run without swap at all.
>  
>
I'm not sure how you knew I had 2GB of swap. ;)
I just always thought it was a good idea to have some just in case.
I did not know having swap would actually, in some cases, degrade
performance.

Are you saying that, if I turn off swap, the amount of cache used will
be the same, but that when other programs need more memory, the kernel
will take it from cache? If so, I will try, since that would be
an ideal solution.

And while O_STREAMING sounds good, I'm not really up for rewriting
all the rsync-like apps. I want my OS to deal with it.

Thanks.

-- tony
"Surrender to the Void." -- John Lennon




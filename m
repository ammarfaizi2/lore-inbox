Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTLFBji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbTLFBji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:39:38 -0500
Received: from moof.zeroth.org ([203.117.131.35]:33289 "EHLO moof.zeroth.org")
	by vger.kernel.org with ESMTP id S264916AbTLFBjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:39:36 -0500
Message-ID: <3FD1334C.80506@metaparadigm.com>
Date: Sat, 06 Dec 2003 09:39:24 +0800
From: Jamie Clark <jamie@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5) Gecko/20031108
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa3 scsi oops
References: <3FA713B9.3040405@metaparadigm.com> <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com> <20031206010505.GB14904@dualathlon.random>
In-Reply-To: <20031206010505.GB14904@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Tue, Nov 04, 2003 at 07:52:40PM +0800, Jamie Clark wrote:
>  
>
>>I made the quick fix (disabling rq_mergeable) and started the load test.
>>Will let it run for a week or so.
>>    
>>
>does your later recent email means it deadlocked again even with this
>disabled?
>  
>
Yes, although it appeared to be a different deadlock: ext3 perhaps.

>Could you try again with 2.4.23aa1 again just in case?
>  
>
I started another test on the same kernel with quotas disabled
as Jan suggested but I had to abort the test for unrelated reason
(needed spare hw). The interesting case for me is WITH quotas.

Will try 2.4.23aa1 as soon as I can re-assemble the test unit.

-Jamie



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVCTXmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVCTXmd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVCTXmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:42:32 -0500
Received: from smtp007.bizmail.sc5.yahoo.com ([66.163.170.10]:26488 "HELO
	smtp007.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261366AbVCTXm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:42:29 -0500
Message-ID: <423E0A63.7050802@embeddedalley.com>
Date: Sun, 20 Mar 2005 15:42:27 -0800
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050319141351.74f6b2a5.akpm@osdl.org> <20050320224028.GB6727@linux-mips.org> <423DFE7C.7040406@embeddedalley.com> <20050320232438.B31657@flint.arm.linux.org.uk>
In-Reply-To: <20050320232438.B31657@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, Mar 20, 2005 at 02:51:40PM -0800, Pete Popov wrote:
> 
>>>>>- __register_serial, register_serial, unregister_serial
>>>>> (this driver doesn't support PCMCIA cards, all of which are based on
>>>>>  8250-compatible devices.)
>>
>>I tried a couple of times to cleanly add support to the 8250 for the Au1x 
>>serial. The uart is just different enough to make that hard, though I admit I 
>>never spent too much time on it. Sounds like it's time to revisit it again.
> 
> 
> I would prefer to have a patch to remove (or ack to do so myself) the
> above three mentioned functions so I can avoid breaking your driver,
> rather than a large update to it.

Go for it. I'll test the driver afterwards and think about getting it into the 
8250 again.

Thanks,

Pete

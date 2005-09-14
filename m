Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVINQWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVINQWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVINQWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:22:18 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:59910 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030239AbVINQWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:22:05 -0400
Message-ID: <43284FA9.3030507@tmr.com>
Date: Wed, 14 Sep 2005 12:28:25 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Sanchez <david.sanchez@lexbox.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Corrupted file on a copy
References: <17AB476A04B7C842887E0EB1F268111E026F9B@xpserver.intra.lexbox.org>
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E026F9B@xpserver.intra.lexbox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Sanchez wrote:
> Hi,
> 
> I'm using the linux kernel 2.6.10 and busybox 1.0 on a AMD AU1550 board.
> 
> When I copy a big file (around 300M) within an ext2 filesystem (even on
> ext3 filesystem) then the output file is sometime "corrupted" (I mean
> that the source and the destination files are different and thus
> generate a different SHA1).

That's likely to be hardware. Have you tried memtest86 or similar? Are 
you overclocked, or running aggressive memory timing?

Similar kernel+bbox installs seem stable on other hardware.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


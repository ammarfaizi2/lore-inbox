Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270855AbTHQUun (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270864AbTHQUun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:50:43 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:7978 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S270855AbTHQUum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:50:42 -0400
Message-ID: <3F40073D.6090202@wanadoo.fr>
Date: Sun, 17 Aug 2003 22:52:45 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: michaelc <michaelc@turbolinux.com.cn>, linux-kernel@vger.kernel.org
Subject: Re: about PENTIUM4 cache line
References: <865464921.20010309170338@turbolinux.com.cn> <20030817202534.GC3543@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> michaelc wrote:
> 
>>     I read the Intel IA-32 developer's manual recently, and I found
>> the cache lines for L1 and L2 caches in Pentium4 are 64 bytes
>> wide, but the thing make me confused is that the default value
>> CONFIG_X86_L1_CACHE_SHIFT option in 2.4.x kernel is 7, why it's
>> not 6?   Any expanation about this would be appreciated!
> 
> 
> I don't recall seeing an answer to this.
> Was there one?

There is some confusion about P4 cache line size but

Intel Software Developer's Manual VOL 1

Page 2.12, Par 2.6:
"128-byte cache line size
  - Two 64-byte sectors"

regards,
Philippe Elie


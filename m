Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271104AbTHLRs7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271117AbTHLRs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:48:59 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:37646 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271104AbTHLRs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:48:56 -0400
Message-ID: <3F392BE0.1060908@techsource.com>
Date: Tue, 12 Aug 2003 14:03:12 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add an -Os config option
References: <20030811211145.GA569@fs.tum.de> <1060695341.21160.2.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> On Llu, 2003-08-11 at 22:11, Adrian Bunk wrote:
> 
>>+config OPTIMIZE_FOR_SIZE
>>+	bool "Optimize for size" if EMBEDDED
>>+	default n
>>+	help
>>+	  Enabling this option will pass "-Os" instead of "-O2" to gcc
>>+	  resulting in a smaller kernel.
>>+
>>+	  The resulting kernel might be significantly slower.
> 
> 
> With most of the gcc's I tried -Os was faster.


Why is -Os faster?  Fewer cache misses?

Wouldn't that make -O2 kinda pointless?  It seems kinda futile to 
optimize for speed just to have it come out slower.



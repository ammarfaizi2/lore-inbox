Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUIOU2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUIOU2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUIOU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:27:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29313 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267358AbUIOUZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:25:24 -0400
Message-ID: <4148A51F.7030909@pobox.com>
Date: Wed, 15 Sep 2004 16:25:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Stevens <dlstevens@us.ibm.com>
CC: Netdev <netdev@oss.sgi.com>, leonid.grossman@s2io.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
References: <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
In-Reply-To: <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Stevens wrote:
> I've never understood why people are so interested in off-loading
> networking. Isn't that just a multi-processor system where you can't
> use any of the network processor cycles for anything else? And, of
> course, to be cheap, the network processor will be slower, and much
> harder to debug and update software.

Well I do agree there is a strong don't-bother-with-TOE argument: 
Moore's law, the CPUs (manufactured in vast quantities) will usually


However, there are companies are Just Gotta Do TOE...  and I am not 
inclined to assist in any effort that compromises Linux's RFC compliancy 
or security.  Current TOE efforts seem to be of the "shove your data 
through this black box" variety, which is rather disheartening.

Even non-TOE NICs these days have ever-more-complex firmwares.  tg3 is a 
MIPS-based engine for example.


> If the PCI bus is too slow, or MTU's too small, wouldn't
> it be better to fix those directly and use a fast host processor that can
> also do other things when not needed for networking? And why have
> memory on a NIC that can't be used by other things?

PCI bus tends to be slower than DRAM<->CPU speed, and MTUs across the 
Internet will be small as long as ethernet enjoys continued success.

	Jeff


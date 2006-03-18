Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWCRQOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWCRQOt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 11:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWCRQOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 11:14:49 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:21376 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751415AbWCRQOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 11:14:48 -0500
Message-ID: <441C31F4.9070209@bootc.net>
Date: Sat, 18 Mar 2006 16:14:44 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: New libata PATA patch for 2.6.16-rc1
References: <1142262431.25773.25.camel@localhost.localdomain> <200603131713.31411.s0348365@sms.ed.ac.uk> <1142299457.25773.43.camel@localhost.localdomain> <200603141048.39785.s0348365@sms.ed.ac.uk> <1142607460.28614.8.camel@localhost.localdomain>
In-Reply-To: <1142607460.28614.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Mar 2006, at 14:57, Alan Cox wrote:

> On Maw, 2006-03-14 at 10:48 +0000, Alistair John Strachan wrote:
>> for FILE in *; do dd if="$FILE" of=/dev/null bs=1M; done
>>
>> 300,000 interrupts later, still no messages. Anything I can do to 
>> isolate this 
>> further?
>
> I left the IRQ trap code define enabled in the tree when I did the diff.
> Ok thats that one explained

Would this cause hangs? I seem to get hangs on SATA I/O occasionally 
(not PATA) which coincide with those IRQ trap messages.

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/




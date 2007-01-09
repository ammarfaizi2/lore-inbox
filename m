Return-Path: <linux-kernel-owner+w=401wt.eu-S1751006AbXAIEGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbXAIEGU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 23:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbXAIEGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 23:06:20 -0500
Received: from tzec.mtu.ru ([195.34.34.228]:3564 "EHLO tzec.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbXAIEGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 23:06:20 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: Strange ethN numbering problem.
To: John Clark <jclark@metricsystems.com>, linux-kernel@vger.kernel.org
Date: Tue, 09 Jan 2007 07:06:15 +0300
References: <E1H45al-0002Xj-00@calista.eckenfels.net> <45A2F218.8010608@metricsystems.com>
User-Agent: KNode/0.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20070109040616.ED8C460BE75@tzec.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Clark wrote:

> Bernd Eckenfels schrieb:
>> In article <45A2E19F.4070307@metricsystems.com> you wrote:
>>   
>>> However, when the system comes up and attempt to do an ifconfig, the
>>> 'ethN' numbers
>>> have changed to a some what intermengled seriese starting with eth6...
>>> eth10.
>>>     
>>
>> maybe a system startup script is renaming them (in order to give them
>> well known numbers)?
>>
>> What kind of distribution is that? is this a new problem? Have a look in
>> /etc/mactab.
> 
> This is not a 'new' distribtution. In fact, the disk was used for a
> previous hardware box, of the same
> manufacturer and allegedly the same cpu mother board.
> 

Then quite likely it remembered lower numbers for "old" interfaces and
starts renaming with next available.

> The kernel is 2.6.19.1 the at-that-moment current linux kernel.
> 
> What should I look for in terms of interface renaming.

I guess in udev rules; look also if you have /etc/iftab. The best you can do
is asking in lists/groups dedicated to your distribution.

-andrey

> What is also sort 
> of strange is that they all
> have the same 'mac' address vendor unique id... even though two
> interfaces are for an Intel
> ethernet chip, and the othe 4 are from the Marvel chip.
> 
> Thanks
> John Clark



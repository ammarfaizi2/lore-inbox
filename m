Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUBOPC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbUBOPC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:02:27 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:6500 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264933AbUBOPC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:02:26 -0500
Message-ID: <402F8A00.8030501@uchicago.edu>
Date: Sun, 15 Feb 2004 09:02:24 -0600
From: Ryan Reich <ryanr@uchicago.edu>
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <1o903-5d8-7@gated-at.bofh.it> <1pkw6-3BU-3@gated-at.bofh.it> <1prnS-4x8-1@gated-at.bofh.it>
In-Reply-To: <1prnS-4x8-1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Coywolf Qi Hunt wrote:
> 
>> Harald Dunkel wrote:
>>
>>>
>>> What would be the correct way to get the filename of a
>>> loaded module? The basename would be sufficient.
>>>
>>>
>> The symbole names used in source code, like function names tend to use 
>> "_", while the file names use "-" IMHO.
>>
> 
> Naturally the symbols in the code use '_', cause for C '-'
> is not allowed within symbol names.
> 
> I am interested in the module file names. 'cat /proc/modules'
> should return the correct module names, but for some modules
> (like uhci_hcd vs uhci-hcd.ko) '_' and '-' are messed up.

According to the modprobe man page, the two symbols are interchangeable.

-- 
Ryan Reich
ryanr@uchicago.edu

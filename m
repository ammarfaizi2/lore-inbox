Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVEJJdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVEJJdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 05:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEJJdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 05:33:01 -0400
Received: from gourmet.spamgourmet.com ([216.218.230.146]:19870 "EHLO
	gourmet.spamgourmet.com") by vger.kernel.org with ESMTP
	id S261596AbVEJJc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 05:32:59 -0400
Message-ID: <42807FC6.10400@spamgourmet.com>
Date: Tue, 10 May 2005 11:32:54 +0200
From: "linuxkernel2.20.sandos@spamgourmet.com" 
	<majsetvger.100.sandos@spamgourmet.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: +linuxkernel2+sandos+f66671bddc.linux-kernel#vger.kernel.org@spamgourmet.com
Subject: Re: E1000 - page allocation failure - saga continues :(
 message 1 of 20)
References: <42806B78.2020708@home.se> <42806EA0.2070501@yahoo.com.au>
In-Reply-To: <42806EA0.2070501@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-mdh_se-MailScanner-Information: Please contact the ISP for more information
X-mdh_se-MailScanner: Found to be clean
X-MailScanner-From: majsetvger.100.sandos@spamgourmet.com
X-Spamgourmet: 
X-Spamgourmet: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin - nickpiggin@yahoo.com.au wrote:

> linuxkernel2.20.sandos@spamgourmet.com wrote:
>
>>  >Anyway i'll try to catch THE option that make the kernel not so happy
>>  >under heavy stress. Stay tuned
>>
>> How did this turn out? Any luck? Im seeing this same problem with my 
>> e1000, now I did enable rx/tx flow control, I reniced kswapd and I 
>> changed vm.min_free_kbytes to 65536, and the problem went away.
>>
>> It would be nice with a "cleaner" solution though.
>>
>
> What kernel are you using?
> Are you doing a lot of block IO as well?

I am using 2.6.11.8.

Yes, the server is a fileserver for both the internet (~10Mbit) and 
internally (1Gbit e1000). Hardware is pretty old so is pretty heavily 
loaded and with 256MB RAM.

---
John Bäckstrand

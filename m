Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUFPT6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUFPT6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUFPT6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:58:50 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:8342 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264701AbUFPT6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:58:49 -0400
Message-ID: <40D0A63F.9000809@comcast.net>
Date: Wed, 16 Jun 2004 15:57:51 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@ximian.com>
CC: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Programtically tell diff between HT and real
References: <20040616174646.70010.qmail@web51805.mail.yahoo.com>	 <1087408567.7869.1.camel@localhost> <1087411607.7869.3.camel@localhost>
In-Reply-To: <1087411607.7869.3.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert Love wrote:
> On Wed, 2004-06-16 at 13:56 -0400, Robert Love wrote:
> 
> 
>>Yah.  Look at /proc/cpuinfo.
>>
>>Virtual processors have different 'processor' values but the same
>>'physical id', while physical processors obviously have different values
>>for both.
> 
> 
> Oh, and if you just want to see if a processor supports HT - the 'ht'
> flag is set in 'flags' in /proc/cpuinfo.

Not always true. I have a non-HT Pentium4, but I still have ht in my 
flags. The same goes for a couple of dual Xeon's I work on at school. 
Aparently Intel disabled the HT on a lot of Pentium 4 and Xeon chips, 
but left the HT flag behind. My system even has the additional IO-APICs 
too. Hence why everytime I boot a UP kernel, I get an 'unexpected 
IO-APIC' message.

Cheers,
David

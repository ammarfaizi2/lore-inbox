Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289558AbSAJRP5>; Thu, 10 Jan 2002 12:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289560AbSAJRPr>; Thu, 10 Jan 2002 12:15:47 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:33072 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289558AbSAJRPS>;
	Thu, 10 Jan 2002 12:15:18 -0500
Message-ID: <3C3DCBA7.4080802@debian.org>
Date: Thu, 10 Jan 2002 18:13:11 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <fa.gs2ktfv.1r00h12@ifi.uio.no> <fa.kj79fuv.1angmqd@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jan 2002 17:15:16.0953 (UTC) FILETIME=[5FB31490:01C199FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Thu, 10 Jan 2002, Alan Cox wrote:
> 
>>We've also proved the DMI data is too unreliable to be used, so the entire
>>problem space is irrelevant
>>
> 
> That's not a problem, remember Eric volunteered to maintain the
> enormous black list 8-)
> 


Surelly I will not maintain the DMI table!
It is already difficult to maintain the database of CPU.
The newer CPUs have name stored directly in CPU and no more
in kernel :-(

(
This is a call for help: how to write a table
CPU - CONFIG_SYMBOL ?
Now I use Vendor/Name/Family/Stepping/, but
maybe with Vendor + flags (CPUID flags) the result
will be more correct?

Other suggestions?

	giacomo

 



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289563AbSAJR2h>; Thu, 10 Jan 2002 12:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289564AbSAJR21>; Thu, 10 Jan 2002 12:28:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60937 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289563AbSAJR2J>; Thu, 10 Jan 2002 12:28:09 -0500
Message-ID: <3C3DCF1F.4070800@zytor.com>
Date: Thu, 10 Jan 2002 09:27:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Giacomo Catenazzi <cate@debian.org>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <E16Oj8m-00050R-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Surelly I will not maintain the DMI table!
>>
> 
> Quite
> 
> 
>>This is a call for help: how to write a table
>>CPU - CONFIG_SYMBOL ?
>>Now I use Vendor/Name/Family/Stepping/, but
>>maybe with Vendor + flags (CPUID flags) the result
>>will be more correct?
>>
> 
> You need the family/model information to get the right optimisations. Its
> often not that the instruction set is different but that the cpu
> implementation is different that determines the choice. With a couple of 
> exceptions cpu type is actually not too important and accidentally using
> 486 will make little difference
>  


Something I'd really like to see would be to split "optimize for..." and 
"run on..." for CPU type; just like gcc has -mmach= and -march=.

	-hpa




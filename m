Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbTAPN2z>; Thu, 16 Jan 2003 08:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbTAPN2z>; Thu, 16 Jan 2003 08:28:55 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:46806 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267079AbTAPN2x>; Thu, 16 Jan 2003 08:28:53 -0500
Message-ID: <3E26B497.8000301@oracle.com>
Date: Thu, 16 Jan 2003 14:33:11 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew McGregor <andrew@indranet.co.nz>
CC: Valdis.Kletnieks@vt.edu, Mikael Pettersson <mikpe@csd.uu.se>,
       vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
References: <15909.13901.284523.220804@harpo.it.uu.se>            <481480000.1042627438@localhost.localdomain> <200301151921.h0FJLvV0009887@turing-police.cc.vt.edu> <3660000.1042685449@localhost.localdomain>
In-Reply-To: <3660000.1042685449@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew McGregor wrote:
> The i8k will power off with APM but not ACPI, but it won't reboot with 
> either.
> 
> I'm using grub, so it may hit the problem before outputting anything 
> where lilo may not.

[Fixed CC: to Vojtech]

CPx750J powers off with grub/APM
C640    powers off with grub/ACPI - much earlier than the CPx

Most likely the same interval of kernel that Valdis mentions. For
  sure both behave like this in 2.5.58.

> --On Wednesday, January 15, 2003 14:21:57 -0500 Valdis.Kletnieks@vt.edu 
> wrote:
> 
>> On Wed, 15 Jan 2003 23:43:58 +1300, Andrew McGregor said:
>>
>>> Possibly related:
>>>
>>> Dell Inspiron 8000s won't warm reboot either.  They just freeze with a
>>> blinking cursor at the point where the bootloader would ordinarily load.
>>> Have to power off or reset.
>>>
>>> Consistent in various versions from 2.5.44 to .55.  Have not tested
>>> earlier, nor yet later.
>>
>>
>> Dell Latitude C840s will power off.  Oddly enough, it doesn't do it when
>> LILO itself loads - it does it when LILO starts loading the actual kernel
>> image.  True from 2.5.46 through 2.5.58.

--alessandro

  "And though it don't seem fair, for every smile that plays
    a tear must fall somewhere"
        (Bruce Springsteen, "The Price You Pay", live 31/12/1980)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUJUMii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUJUMii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268565AbUJUMib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:38:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9088 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261610AbUJUMeJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:34:09 -0400
Date: Thu, 21 Oct 2004 08:33:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "John W. Linville" <linville@tuxdriver.com>
cc: netdev@oss.sgi.com, Linux kernel <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, romieu@fr.zoreil.com
Subject: Re: [patch 2.6.9 9/11] r8169: Add MODULE_VERSION
In-Reply-To: <20041020155938.T8775@tuxdriver.com>
Message-ID: <Pine.LNX.4.61.0410210823510.10982@chaos.analogic.com>
References: <20041020141146.C8775@tuxdriver.com> <20041020142858.L8775@tuxdriver.com>
 <Pine.LNX.4.61.0410201629120.6918@chaos.analogic.com> <20041020155938.T8775@tuxdriver.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-544832866-1098362031=:10982"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678434306-544832866-1098362031=:10982
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Wed, 20 Oct 2004, John W. Linville wrote:

> On Wed, Oct 20, 2004 at 04:34:45PM -0400, Richard B. Johnson wrote:
>>
>> This makes warning error about :
>>
>> Warning: could not find versions for .tmp_versions/r8169.mod
>>
>> Do I have to enable something in .config (like CONFIG_MODVERSIONS)?
>> If so, how does one make this transparent, to get rid of the
>> warning if CONFIG_MODVERSIONS is not set?
>
> Odd...I don't get any such warning, with or without
> CONFIG_MODVERSIONS...
>
> MODULE_VERSION is used elsewhere -- do you get that warning
> from any other modules?  Was this from a clean build?
>
> Send me your .config, and I'll look into it.
>
> Thanks,
>
> John

It's a generic problem with compiling modules outside of
the kernel. The attached module, complete with its Makefile
shows the problem.

We really need to fix such problems because, to use the
same kernel for a development effort means that the kernel
sources are on some NFS server, not writable by developers.
They have write permissions only for their own workstations.
Therefore, one can't copy their sources to the kernel tree,
modify .config and then develop their modules.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
--1678434306-544832866-1098362031=:10982
Content-Type: APPLICATION/x-gzip; name="demo.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0410210833511.10982@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="demo.tar.gz"

H4sIAPqpd0EAA+0Xa2/bNjBfrV9xcJBONmxZcuIGS5phiet0bpM4cJJuQxM4
tETZqiXSI6WkxtD/viMlP+OmWAEXK6YDbEl3x3vzjvRoxGtbmwXb3rP3Gw18
alh96nfHdnYb+/W9/T1ny3bshmNvQWPDdmlIZEwEwJbgPH6O72v0HxQ8lf9z
MqJ+ENIN6cB82i/39r6Yf0Wb5d9GPqfuNDD/9obsWYL/ef63je3CpeAfqRvD
tAzA5wJGVDAawgMVMuBMAsc3eAnI3hSUxNQDu1HtNK+rddzehW7gDonw4MSC
t3zIJGfGtmEYJAwPCgV3OBp6QsLr1vt2s2UUCr9atQyHHxFqhWoTaokUNSnc
Whiw5FP1PmEkQoK4h6ubk9ft7tXR/fjRu4eIe0lIpWHw/sdqVCgcHEEhxVnc
MNK3KtIkUgpyyB8tXjCMTN/B1BjLRdUD14Vqpw7V39FQqHKYWjpnMlKj517g
MhFB1Z97E40Y9yD7Bhec/X2wUWNICTvI2IUPZYvjb6T+0EjLhVurbLmRN114
O7URCXE07k0jbxibzL/e/zN3N6PjK/sfN3t9tv/3Gqr/1+v7jXz/fw+olQ0o
A0CTjyciGAxj0y3hp9rU+DhmJOSDwEWyGHNBYixI5E+XXA8DCWPBB4JEEJEJ
9Cl4gYxF0E9Uf0iYhy0jHlJ4c3EDl0k/REFngUuZpKmErMShXgGCohSHHOLK
/kQvOxWUwhX340ci8IujQG1BBdrMtSqpjMbPcE2jMXaty5C4tAJXSRBT2N21
4YTLWHGfH1cAq8xxrJntp6rNzcq+MOtpTr16fvznF3vakusfsXRQBnVHEs0l
sbbZ5UKoXpq1zyElGAQJygHyQIKQ9MPMecn1gowxix+Gc0xFOEE50Rht9JTJ
NWM7YG6YeBReydgLuDX8ZQGVMAy6t4xDRBj0V3EiYIMV3ETWkliqVqsIRsBi
NCVgpnohYiAroIIAZXx/+HBXMv420PQU10/8D/Yn3Nt3hxqJ8hP0PBOnnine
fOCBV9Lt3HyB2FLGPkZzYt9EMRUornT/HVnLbEwRxYqSZwmKTVXSTELgm8R1
qZSpjNNe512ppCmplQr8TAsGhAqBii6wyyeYI7aSI1CTD93dkZVbhupQZKZm
rZinIxJXWnrlU0PXSrjUHODqygMCchJV0dcRcF8Xhs/DkD9ixtQ4jg5Q9HPS
QgZVCebjkGKlLdSV5InAEKkCLEHxFsdR4WmsnzF7mjxlmamLwL5bINNPQWy2
/mhf906P22c33VZG+6z/BY0TwcA+ND5vdorl8K2g578+JW1o+G99ff436vP7
X91W89956ezn8/97gJ7/P/g8rxkLE033tFpmyfKwS0nxZEzlOkJ2iVhDCVgQ
r8OnPXYdBZsy4+sIvlZtbHt402IUXXnb6fYuuurSYKhWC3+hu2nTPdTTuNdT
2kFVaZyMpxT8jDH6isFLomhiZsM3wKsIhXIwrkzHsb7Qlf3xfNECoadOGzoH
EnxyaBjnndc3Z63eGV5ILq5aZvHN5ZkaOxn6fat71e5cmEWnvrvXUASjVltd
khWGx9U5ojhX66KSOD05qKPAh7ujYseNBWEDNLDJGb72k5DEXJhxVCqi7G9w
MjufLA2eeVinZCURWVBFdoww8QuOsMIFHWDFU9Fzh8KjD+Y0PxVtc6kEr+zV
E4aexCPzXat70Ts+a3WvizsSDqBJ2E/xgkS9AzwSMXxRQ93c8Up67irBFWXO
wlhN7V8cpYta2hennVRJF7v3A/Vmckra4TVl88RzfYggFn9kaBqg79e/ta96
aS7n1DFloKk6/jN8dkxYxs/D+HwQK/DCJ/8+kl+I46Lry9Gb+/lcBNtYlHj5
X47hagmlnaGnDzuqkJAlQ6kgm1mQ1XbITzk55JBDDjnkkEMOOeSQQw455JBD
Djn8p+AfppqmCwAoAAA=

--1678434306-544832866-1098362031=:10982--

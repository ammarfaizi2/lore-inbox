Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269777AbRHIMGH>; Thu, 9 Aug 2001 08:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269778AbRHIMF5>; Thu, 9 Aug 2001 08:05:57 -0400
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:62090 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S269777AbRHIMFn>; Thu, 9 Aug 2001 08:05:43 -0400
Message-ID: <3B712B23.5090700@kjellander.com>
Date: Wed, 08 Aug 2001 14:05:55 +0200
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 386 boot problems with 2.4.7 and 2.4.7-ac9
In-Reply-To: <Pine.LNX.4.33.0108091228380.6063-100000@druid.if.uj.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski wrote:
>>The system is a 386DX with an Award 3.15c BIOS. The distribution
>>is smalllinux i think, but I've modified it a lot.
>>
> 
> 99% sure that your problem is binaries for 486 and up, had this problem
> installing RedHat 7.1 on a 486 with no CDROM drive - did the installation
> on a Pentium 3, then it would not boot, compiled a new kernel for 486,
> installed that on the P 3, now it booted on the 486 but would not run
> init.  The binaries were for 686 and refused to run...

As I said in my post, the distribution is not Red Hat, but smalllinux,
a very tiny floppydistribution that runs on a 386 with as low as 2MB RAM
(Mine has 4MB).

I only compile new kernels on my Red Hat machine and yes I do compile
it for the 386:

# Processor type and features
#
CONFIG_M386=y

My 386 boots stock 2.4.3 fine but not 2.4.7.

> PS. There should be a choich when installing RedHat in advanced mode what
> processor you want to install for - often enough the computer you are
> installing on is not quite the same as the one it will be running on.
> 

You can do always try to install from the harddrive or via NFS, ftp or
http from your other machines. Red Hat does a lot of smart things during
the install and you have to make sure that for instance glibc is not
the i686 rpm.

/Carl-Johan Kjellander

-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`


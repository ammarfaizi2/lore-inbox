Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282859AbRK0IGf>; Tue, 27 Nov 2001 03:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282851AbRK0IGW>; Tue, 27 Nov 2001 03:06:22 -0500
Received: from avalon.informatik.uni-freiburg.de ([132.230.150.1]:4844 "EHLO
	avalon.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id <S282859AbRK0IGA>; Tue, 27 Nov 2001 03:06:00 -0500
Message-ID: <3C034944.1090501@gmx.de>
Date: Tue, 27 Nov 2001 09:05:24 +0100
From: Jochen Eisinger <jochen.eisinger@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alex Riesen <riesen@synopsys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 alsa 0.5.12 mixer ioctl problem
In-Reply-To: <HKEMJNBMMEMMAEHPEBGNCEBNCBAA.riesen@synopsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This appears to be a problem with fs/proc/inode.c. Reverting to the 
version up to 2.4.15-pre6 will solve your problem.

regards
-- jochen

Alex Riesen wrote:

> Hi, all
> 
> just tried to compile the mentioned alsa drivers under 2.4.16.
> Mixer doesnt work, yes. It compiles, installs, loads. And
> any program trying to open mixer (through libasound) get EINVAL.
> 


-- 
   "I'd rather die before using Micro$oft Word"
     -- Donald E. Knuth
      (asked whether he'd reinvent TeX in the light of M$ Word)

   GnuGP public key for jochen.eisinger@gmx.de:
       http://home.nexgo.de/jochen.eisinger/pubkey.asc (0x8AEB7AE3)



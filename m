Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSD2JA1>; Mon, 29 Apr 2002 05:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314940AbSD2JA0>; Mon, 29 Apr 2002 05:00:26 -0400
Received: from xsmtp.ethz.ch ([129.132.97.6]:18474 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S314938AbSD2JAZ>;
	Mon, 29 Apr 2002 05:00:25 -0400
Message-ID: <3CCD0B66.4040107@debian.org>
Date: Mon, 29 Apr 2002 10:59:18 +0200
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjan@fenrus.demon.nl
CC: Matthew M <matthew.macleod@btinternet.com>, linux-kernel@vger.kernel.org
Subject: Re: Microcode update driver
In-Reply-To: <fa.fn3ukrv.1ghovg0@ifi.uio.no> <fa.hho4jnv.11lkl19@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Apr 2002 09:00:25.0181 (UTC) FILETIME=[4D0CF8D0:01C1EF5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



arjan@fenrus.demon.nl wrote:

> In article <m171Yag-000Ga6C@Wasteland> you wrote:
> 
>>On Saturday 27 April 2002 7:57 pm, Roy Sigurd Karlsbakk wrote:
>>
>>>Sorry if this is a FAQ, but where's the microcode.dat supposed to be
>>>placed? I can't find any information about that in the doc.
>>>
>>/usr/share/misc/microcode.dat
>>
> 
> hum doesn't the FHS specify that /usr/share shouldn't contain arch
> specific files ? microcode.dat I can't really call arch neutral....


Right! But is not a configuration file (in /etc/, like the original sources
and RH). So it should be in /usr/lib (or in /usr/include, it is really a C/C++
file, but now we don't use it as a C file).

Anyway, I will no change the location [1]. The file is a nearly a C file, so
no problems with other archs. I see it as the man pages of lilo, and other
arch specific program. They are in /usr/share, readable by all arch,
but not so usefull on other arch.

	giacomo

PS: Do you maintain the RH kernel-utils ?


[1] until I find a good new location in FHS


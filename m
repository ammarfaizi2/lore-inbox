Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVI0Mn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVI0Mn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVI0Mn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:43:29 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:65288 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S964894AbVI0Mn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:43:28 -0400
Message-ID: <43393E76.2050008@rainbow-software.org>
Date: Tue, 27 Sep 2005 14:43:34 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <grant_lkml@dodo.com.au>
CC: "=?ISO-8859-1?Q?Rog=E9rio_Brito?=" <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
References: <20050927111038.GA22172@ime.usp.br> <9ncij11fqb4l70qrhb0a8nri5moohnkaaf@4ax.com>
In-Reply-To: <9ncij11fqb4l70qrhb0a8nri5moohnkaaf@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> On Tue, 27 Sep 2005 08:10:39 -0300, Rogério Brito <rbrito@ime.usp.br> wrote:
> 
> 
>>Hi there. I'm seeing a really strange problem on my system lately and I
>>am not really sure that it has anything to do with the kernels.
> 
> 
> Probably not, I had a similar problem recently and for a test case 
> copied a .iso image file then compared it to original (cp + cmp), 
> turned out to be bad memory, and yes, memtest86 did not find the 
> problem.  Check mobo datasheet if 2+ double-sided memory allowed, 
> you may need to stay at 1GB to reduce bus loading.

I work a lot with hardware any my experience is that memtest is not very 
good at detecting errors. I have a Socket 7 board somewhere with bad L2 
cache - it was unstable but memtest was unable to find anything. 
However, GoldMemory found some errors - they disappeared after disabling 
L2 cache and crashes disappeared too. It's not free but at least 
shareware - you can find it at http://www.goldmemory.cz/ The older 
version (IIRC 5.07) was better, I had problems with some of the newer 
ones on perfectly OK hardware (when the test should start, it rebooted 
instead).

-- 
Ondrej Zary

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284553AbRLRSyE>; Tue, 18 Dec 2001 13:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284617AbRLRSwy>; Tue, 18 Dec 2001 13:52:54 -0500
Received: from mout0.freenet.de ([194.97.50.131]:26859 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S284557AbRLRSvh>;
	Tue, 18 Dec 2001 13:51:37 -0500
Message-ID: <3C1F901E.6050800@athlon.maya.org>
Date: Tue, 18 Dec 2001 19:51:10 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17rc1] fatal problem: system time suddenly changes
In-Reply-To: <Pine.LNX.4.21.0112181509150.4456-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

thank you for your reply!


Marcelo Tosatti wrote:

> Andreas, 
> 
> I have no idea why this is happening.
> 
> Could you please 2.4.16 ?
> 


It's with all 2.4.x-kernels. The only ones working fine have been the 
ac-patches.

When running the ac-patches, I often got the following message in 
/var/log/messages. I put them as example here, that you can see, how 
often it appears:

Oct  7 10:36:04 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:36:04 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:36:10 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:36:10 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:36:20 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:36:20 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:36:41 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:36:41 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:37:45 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:37:45 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:38:02 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:38:02 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:45:54 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:45:54 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:02 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:02 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:04 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:04 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:05 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:05 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:13 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:13 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:20 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:20 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:27 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:27 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:28 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:28 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:35 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:35 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:41 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:41 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:43 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:43 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:46:59 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:46:59 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:47:04 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:47:04 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:47:10 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:47:10 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:47:12 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:47:12 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:47:33 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:47:33 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:47:34 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:47:34 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:47:36 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:47:36 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:47:40 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:47:40 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:47:41 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:47:41 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:47:45 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:47:45 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:03 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:03 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:09 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:09 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:10 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:10 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:11 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:11 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:30 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:30 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:32 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:32 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:34 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:34 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:36 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:36 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:38 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:38 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:41 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:41 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:43 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:43 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:48 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:48 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:50 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:50 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 10:48:56 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 10:48:56 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 11:05:45 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 11:05:45 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 11:06:15 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 11:06:15 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 11:06:17 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 11:06:17 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct  7 11:20:42 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct  7 11:20:42 athlon kernel: probable hardware bug: restoring chip 
configuration.
Oct 29 10:44:26 athlon kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Oct 29 10:44:26 athlon kernel: probable hardware bug: restoring chip 
configuration.

> On Tue, 18 Dec 2001, Andreas Hartmann wrote:
> 
> 
>>Hello all,
>>
>>I'm running kernel 2.4.17rc1 and I detected suddenly changes of
>>systemtime. I saw it in KDE and tested it afterwards in a konsole. I
>>repeated as fast as possible the date program as following:
>>


Regards,
Andreas


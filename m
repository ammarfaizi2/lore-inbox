Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132822AbRC2TRO>; Thu, 29 Mar 2001 14:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132819AbRC2TRE>; Thu, 29 Mar 2001 14:17:04 -0500
Received: from malcolm.ailis.de ([62.159.58.30]:26378 "HELO malcolm.ailis.de")
	by vger.kernel.org with SMTP id <S132825AbRC2TQp>;
	Thu, 29 Mar 2001 14:16:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Klaus Reimer <k@ailis.de>
Organization: Ailis
To: Bill Nottingham <notting@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Date: Thu, 29 Mar 2001 21:13:20 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01032910124007.00454@neo> <01032920202300.00483@neo> <20010329133927.A9950@devserv.devel.redhat.com>
In-Reply-To: <20010329133927.A9950@devserv.devel.redhat.com>
MIME-Version: 1.0
Message-Id: <01032921132002.00483@neo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Control I/O: 0x538
> > MPU I/O: 0x330
> Hm, OK, then never mind. :) I don't have an opl3sa2 here to test
> how well the current driver works.

I have the feeling that there is going something wrong with the parameters. I 
modified the opl3sa2 driver and manually set the hw_config->io_base variable 
to 0x538 and now THIS part of the sound card initialization is working. But 
now it says that there is an I/O conflict with MSS. Maybe this parameter is 
also 0x0 and not  0x530 as I specified with the mss_io parameter... I will 
investigate further...

-- 
Bye, K
[a735 47ec d87b 1f15 c1e9 53d3 aa03 6173 a723 e391]
(Finger k@ailis.de to get public key)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130403AbRCIAkp>; Thu, 8 Mar 2001 19:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130428AbRCIAkf>; Thu, 8 Mar 2001 19:40:35 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:28681 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S130403AbRCIAkU>;
	Thu, 8 Mar 2001 19:40:20 -0500
Message-ID: <3AA82616.F467A9B9@yahoo.co.uk>
Date: Thu, 08 Mar 2001 19:38:46 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-thinkpad@www.bm-soft.com
Subject: Re: 2.2.18 corruption: IDE + PCMCIA ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen the same sort of problem in the past.

My conclusion was that there was a problem with dynamic 
registering and unregistering of ide interfaces.

Thomas Hood
jdthood_AT_yahoo.co.uk

> I've experienced some disk corruption on my laptop.
> 
> Scenario:
> I'm cross-compiling tons of sources and I felt the need
> to insert a CompactFlash card (via PCMCIA) in my laptop.
> So I did, no problem: 
> mounted, touched a file, umounted, cardctl-ejected.
> 
> Pretty soon my compilation stops:
> bash: /usr/bin/sort: cannot execute binary file
> 
> Okey. The date on /usr/bin/sort is unchanged. Must be root to write.
> [...]

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263073AbTC1RaU>; Fri, 28 Mar 2003 12:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263074AbTC1RaU>; Fri, 28 Mar 2003 12:30:20 -0500
Received: from aibo2.runbox.com ([193.71.199.138]:44725 "EHLO aibo.runbox.com")
	by vger.kernel.org with ESMTP id <S263073AbTC1RaT>;
	Fri, 28 Mar 2003 12:30:19 -0500
From: Chris Bacott <cbacot@runbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: eepro100: wait_for_cmd_done timeout
Date: Fri, 28 Mar 2003 11:42:00 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303281142.00430.cbacot@runbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the suggestion...
> I got another one, telling me to have a look at the e100 driver,
> and this raises a question I have for quite a long time : why does
> the Kernel have two different supports for the same hardware ?
> Is this a migration plan, a long run "please switch from eepro100
> to e100" ?
> Is there a better working one ?
>
Becuase, IIRC, eepro100 is the original EtherExpress100 Nic driver written by 
Becker. the e100 Driver is written initially by Intel, and is a obviously 
newer. Question is, would you want to use a driver written by the 
manufacturer of the chip itself, or use a driver that has been in use for 
MANY years, and has been proven solid. I have an eepro in my laptop, and I 
just bought two IBM Etherjet NICs, all use this chip. I'm currently using the 
eepro100 driver, as thats the one I've used for years, but from what I've 
seen. e100 is going to be the one actively updated, as its Intel's driver. 
This is the info I got from the IBM and Intel site when I was looking up 
whether those Etherjet cards were supported in Linux before I bought them. 

If any of the above is wrong, some one *please* correct me. I'd rather be told 
I'm wrong rather than be wrong and thinking I'm right.

-- 
Chris Bacott


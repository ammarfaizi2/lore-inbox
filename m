Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285257AbRLMX13>; Thu, 13 Dec 2001 18:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285260AbRLMX1K>; Thu, 13 Dec 2001 18:27:10 -0500
Received: from chiark.greenend.org.uk ([212.22.195.2]:61957 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S285257AbRLMX1B>; Thu, 13 Dec 2001 18:27:01 -0500
Date: Thu, 13 Dec 2001 23:26:59 +0000 (GMT)
From: "Jonathan D. Amery" <jdamery@chiark.greenend.org.uk>
To: Markus Hetzmannseder <hetzi@hetzi.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C686 && APM deadlock bug?
In-Reply-To: <Pine.LNX.4.40.0112131125540.26191-100000@hetzmannseder.inst-4.ufg.ac.at>
Message-ID: <Pine.LNX.4.21.0112132325570.4294-100000@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Markus Hetzmannseder wrote:

> I have the same deadlock problem like you with the same VIA-chipset, my
> Laptop is a gericom hydrospeed. I can reproduce it by mounting a cd in the
> cd-drive. (My kernel is a 2.4.16 with ide-cd modules)
> 
> Steps to generate a deadlock on my notebook:
> 
> 1. mount a normal cd
> 2. unmount the cd-drive
> 3. make a apm --suspend
> 4. wake up the laptop
> 5. try to remount the cd
> 6. the laptop get immediately lockt!
> 
> Please try out this, i think it could be the same problem?
> 

 This doesn't happen.  This is however the first time I've apm --suspended
the laptop, and it doesn't really like it (screen corruption in text
mode).

-- 
Jonathan Amery.      Now there's a light at the end of the tunnel,
   #####                Someone's lit a campfire in my cave.
  #######__o         The first rays of dawn are breaking through the clouds,
  #######'/             And somehow I know I can be brave.      - Steve Kitson


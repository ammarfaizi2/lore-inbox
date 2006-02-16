Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWBPQRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWBPQRT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWBPQRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:17:18 -0500
Received: from mail.tmr.com ([64.65.253.246]:59289 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932309AbWBPQRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:17:18 -0500
Message-ID: <43F4A632.8000500@tmr.com>
Date: Thu, 16 Feb 2006 11:20:02 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Jens Axboe <axboe@suse.de>, Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rmatthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <Pine.LNX.4.61.0601262139290.27891@yvahk01.tjqt.qr> <20060127080026.GR4311@suse.de> <43DE98B9.6010008@tmr.com> <74B203F5-441F-4953-A95D-FEA162700876@mac.com>
In-Reply-To: <74B203F5-441F-4953-A95D-FEA162700876@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> On Jan 30, 2006, at 17:52, Bill Davidsen wrote:
>
>> What is not easily available in Linux is a nice single place to  find 
>> out what mass storage (disk/optical/floppy/ZIP/LS120/tape)  devices 
>> are on the system, and what the system calls them.
>
>
> Yes it is available, and a whole slew of GUI applications use it.   
> It's called "hal", or Hardware Abstraction Layer, and it has small  
> hooks into udev and a bit of sysfs code so that it has a list of all  
> devices of various types and knows what their associated udev-created  
> device nodes are.  This means that I can configure udev to put my CD  
> drive on /dev/burner and correctly written GUI programs will just  
> find it and work.

I was really talking about something stable. HAL is an application, and 
as such has to be changed avery time some developer has a bad dream and 
changes the interface, moves a comtrol or report from /proc to /sys, or 
otherwise requires a new way of interpreting the data. If you will, HAL 
*in* the kernel where it must work.

> -- 
> I have yet to see any problem, however complicated, which, when you  
> looked at it in the right way, did not become still more complicated.
>   -- Poul Anderson

-- 

bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTDVVM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 17:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263863AbTDVVM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 17:12:56 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:33235 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S263849AbTDVVMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 17:12:55 -0400
Message-ID: <3EA7045C.1040008@softhome.net>
Date: Thu, 24 Apr 2003 02:53:40 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] fbcon
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>There seems to be a problem in the frame buffer console, It appears 
as >>if the
 >>resolution has been changed from 1024x768 to 1024x800 or something 
 >>like that
 >>(I can only half see the sh prompt when it has come down), but the 
 >>argument I
 >>passed at boot time was still 788. It doesn't appear to have been 
 >>solved
 >>according to the bk csets taken from kernel.org.
 >>

 >Did you reset your monitor so it remembers the height/width/centering >for
 >your new resolution? Maybe you didn't know?
 >
 >Cheers,
 >Dick Johnson
 >Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
 >Why is the government concerned about the lunatic fringe? Think about >it.

Thats not the problem (I still checked it though)

The problem is that screen that is showed will fit 1024x773 and not 
1024x768. Everything that I open starts at the very top of my screen but 
ends 3 or 4 pixels below. This does not happen with older kernels and 
with X and it is _not_ a monitor problem.


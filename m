Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270121AbRHWNTb>; Thu, 23 Aug 2001 09:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270132AbRHWNTV>; Thu, 23 Aug 2001 09:19:21 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:55304 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S270121AbRHWNTD>; Thu, 23 Aug 2001 09:19:03 -0400
Message-ID: <71714C04806CD51193520090272892178BD4FA@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: ptb@it.uc3m.es, pozsy@sch.bme.hu
Cc: linux-kernel@vger.kernel.org
Subject: RE: Shutdown and power off on a multi-processor machine
Date: Thu, 23 Aug 2001 08:05:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When things go badly, it just sits there at the "rebooting" 
> stage, and needs the red button to be pressed.
> 
> The machine that most annoys me in this regard is the dell 
> poweredge at which I am sitting ... 

Which PowerEdge?  2.4.7-ac11 includes a patch to allow "SMP" reboots
reboot=bios,smp
reboot=bios

and auto-detects the need for that on the PowerEdge 300 and 1300.  SMP
reboots make sure that the reboot code runs on the bootstrap processor.
Please give this at try.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!

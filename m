Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292341AbSBULbJ>; Thu, 21 Feb 2002 06:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292343AbSBULa7>; Thu, 21 Feb 2002 06:30:59 -0500
Received: from casbah.gatech.edu ([130.207.165.18]:53414 "EHLO
	casbah.gatech.edu") by vger.kernel.org with ESMTP
	id <S292341AbSBULam>; Thu, 21 Feb 2002 06:30:42 -0500
Subject: Re: more detailed information about the AMD 1.6+ GHz MP smp-problem
	with latest kernel
From: Rob Myers <rob.myers@gtri.gatech.edu>
To: mw@suk.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020221102156Z291449-889+4453@vger.kernel.org>
In-Reply-To: <20020221102156Z291449-889+4453@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 21 Feb 2002 06:31:12 -0500
Message-Id: <1014291072.1243.81.camel@ransom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ive got the same motherboard with the same results.

2.4.18-rc2 and 2.4.18-rc2-ac1 would not boot

redhat's latest 2.4.9 version would only boot with noapic passed to the
kernel and the bios had mps 1.4 spec on and mp table disabled. but
sometimes that paniced and would not boot.

if anyone knows what bios settings and kernel bits make this board
stable please pass that info along...

thanks

rob.

On Thu, 2002-02-21 at 05:21, mw@suk.net wrote:
> Dear list members,
> 
> As I've posted a message before not including detailed information about the system, I'm now
> posting with very detailed information looking for help to get everythign fixed ;-)
> 
> Motherboard: ASUS A7M266-D, AMD-760MPX
> CPU: AMD Athlon 1600+ 266 FSB
> RAM: DDRAM, 512 MB, PC266 ECC registered
> 
> 
> The system is a RedHat 7.2 linux installation ... I've first attempted with the included SMP-kernel
> which didn't work. Then updated the system with the latest RedHat-build kernel ... rebooted,
> SMP-kernel still didn't work. So I saw the last chance in building my own kernel, included some
> multi-cpu stuff. The system hang after detecting the 2nd CPU ...
> 
> Anybody can provide help to make the 2 CPU's work? ;-)
> 
> 
> Cu,
> mw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



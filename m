Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWAPSCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWAPSCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWAPSCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:02:05 -0500
Received: from hera.kernel.org ([140.211.167.34]:48813 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750982AbWAPSCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:02:03 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 3COM 3C940, does not work anymore after upgrade to 2.6.15
Date: Mon, 16 Jan 2006 10:01:56 -0800
Organization: OSDL
Message-ID: <20060116100156.0a273b54@dxpl.pdx.osdl.net>
References: <6e6e20a10601160751v362d2312v6c99fa8db64ce7e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: build.pdx.osdl.net 1137434519 10231 10.8.0.74 (16 Jan 2006 18:01:59 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 16 Jan 2006 18:01:59 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006 16:51:22 +0100
Björn Nilsson <bni.swe@gmail.com> wrote:

> Hi,
> 
> I have a problem with the network card attached to my motherboard
> after doing an upgrade of the kernel from 2.6.11 to 2.6.15.
> 
> The Motherboard is an ASUS P4P800, and the network card is 3COM 3C940
> and is afaik a variant of SysKonnect SK-98xx.
> 
> It worked with 2.6.15 until I shut the system down and started it up
> again for the first time with 2.6.15 running, and now the card does
> not work anymore. The driver is loaded, and it detects that the cable
> is plugged in and the interface is brought up (so says dmesg). The
> green led on the card is now turned off, it used to be on before.
> 
> I have tried to reinstall the system from scratch (Using Debian 3.1
> installer cd), and to my astonishment the card is not working like it
> used to.
> 
> It seems like 2.6.15 set the card in some state so it does not work
> anymore. Is this even possible? I have tried power cycling, even
> disconnected the power coord from the computer.
> 
> When i used 2.6.11 I was using the sk98lin driver, when upgrading it
> is possible the newer skge driver was used, however I am not sure.
> 
> Debian installer 3.1 uses 2.6.8 kernel with sk98lin driver.
> 
> I have found others with the same/similar problem:
> http://bugs.gentoo.org/show_bug.cgi?id=100258
> http://marc.theaimsgroup.com/?l=linux-netdev&m=112268414417743&w=2
> 
> But for me the card does not work even with 2.6.15. I dont have
> Wind*ws to test with, so I cant test the solution in one of the above
> emails.
> 
> If the driver in 2.6.15 breaks cards of this type it is qiute a
> serious bug I think. Anyone have any suggestions as to how I can try
> to fix this? Reset the card in some way maybe?
> 
> Please CC me.
> 
> Regards
> /Björn

Pleas send me some more info.
* console output (dmesg)
* lspci -v
* which modules are loaded (lsmod)


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger

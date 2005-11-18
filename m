Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbVKRLuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbVKRLuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 06:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVKRLuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 06:50:19 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:51872 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1161078AbVKRLuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 06:50:18 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: Compaq Presario "reboot" problems
Date: Fri, 18 Nov 2005 13:48:59 +0200
User-Agent: KMail/1.8.2
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com> <437D118A.3000306@rainbow-software.org>
In-Reply-To: <437D118A.3000306@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511181348.59957.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 November 2005 01:26, Ondrej Zary wrote:
> linux-os (Dick Johnson) wrote:
> > It appears as though Linux is still restarting as a "warm boot",
> > rather than a cold boot (in other words, putting magic in the
> > shutdown byte of CMOS) so the hardware doesn't get properly
> > initialized. Would somebody please check this out. When changing
> > operating systems, you need a cold-boot.
> No, it does not. I know that my desktop PC reboots with a beep (and 
> shows CPU information) from Linux - and it does not beep when rebooting 
> from Windows 98.
> Some BIOSes don't like when some devices are in some state. One example 
> is my DTK FortisPro TOP-5A notebook - when rebooted from Linux, it hangs 
> during POST - the fix was to add setpci <someting> to shutdown scripts 
> to zero-out some cardbus controller registers.

Did you report it to lkml and/or dirver maintainer?
--
vda 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268482AbTANB3l>; Mon, 13 Jan 2003 20:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268485AbTANB3l>; Mon, 13 Jan 2003 20:29:41 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:45847
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S268482AbTANB3k>; Mon, 13 Jan 2003 20:29:40 -0500
Message-ID: <3E236A0F.2080605@rackable.com>
Date: Mon, 13 Jan 2003 17:38:23 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Soeren Sonnenburg <bugreports@nn7.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system freezes when using udma on promise pdc20268
References: <1042492068.1199.11.camel@sun>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2003 01:38:26.0501 (UTC) FILETIME=[A2168750:01C2BB6D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:

>Hi!
>
>I experience cold freezes of my new system reproducably (can still
>toggle numlock, but on alt+sysrq+t it freezes completely, watchdog_nmi=1
>does not help so no printout over serial console) when I enable any 
>udma mode >0 using the old or new pdc202xx driver.
>
>However the system seems to work stably (as far I can tell) when using
>the mdma0 or pio modes.
>
>The setup is asus a7v8x with sound/ide/firewire onboard. Two 180GB WDC
>WD1800JB-00DUA0 on the primary and secondary internal VIA controller and
>3 drives on two pdc20268, where the third hard disk is on the secondary
>controller (I explain later why!). All harddisk are jumpered to be
>master's.
>  
>
  Are you stating this correctly.   You've got 2 drives on the PDC20268 
on a single ide chain jumpered as masters?  You should have one jumpered 
as a master and a as a slave.  A single ide chain can have only one master.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>




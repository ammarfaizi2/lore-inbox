Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313649AbSDEWWl>; Fri, 5 Apr 2002 17:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313657AbSDEWWb>; Fri, 5 Apr 2002 17:22:31 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9999 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S313649AbSDEWWV>; Fri, 5 Apr 2002 17:22:21 -0500
Date: Fri, 5 Apr 2002 18:17:47 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Albert Max Lai <amlai@bitsorcery.com>
Cc: "Marc A. Volovic" <marc@bard.org.il>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x and DAC960 issues
In-Reply-To: <15533.61664.984655.18344@bitsorcery.com>
Message-ID: <Pine.LNX.4.21.0204051817180.11472-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Apr 2002, Albert Max Lai wrote:

> On Friday, 5 April 2002, Marc A. Volovic wrote:
> 
> > I am using a Mylex 170LP with no problem, running on a dual 550MHz 
> > MSI 6120S under quite a few 2.4.x kernels, lately 2.4.18 and 2.4.19pre5,
> > all under reiserfs.  The firmware is 6.00-15, carrying 6 9GB disks
> > (5 RAID5 + 1 spare).
> > 
> > There have been NO lockups under any version of the kernel, not under 
> > multiple bonnie runs.
> > 
> > What is your interrupt breakdown? Could your machine be doing something
> > naughty with the interrupts?
> 
> This what /proc/interrupts says:
>            CPU0       CPU1       
>   0:    3874524          0          XT-PIC  timer
>   1:      18836          0          XT-PIC  keyboard
>   2:          0          0          XT-PIC  cascade
>   4:          4          0          XT-PIC  serial
>   5:      46479          0          XT-PIC  soundblaster
>   8:     218807          0          XT-PIC  rtc
>   9:     128424          0          XT-PIC  aic7xxx, aic7xxx
>  10:      52035          0          XT-PIC  Mylex DAC1164P
>  12:     342261          0          XT-PIC  PS/2 Mouse
>  14:     209669          0          XT-PIC  eth0
>  15:      44772          0          XT-PIC  eth1, usb-uhci
> NMI:          0          0 
> LOC:    3874766    3874768 
> ERR:         16
> MIS:          0

I've forwarded your first message to Leonard (the driver author)... well
probably get some feedback soon.


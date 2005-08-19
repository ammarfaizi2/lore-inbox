Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVHSPNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVHSPNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVHSPNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:13:16 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:62149 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750865AbVHSPNP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:13:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vm3wQLrWUo6MmXr+Wi7slcpKwM65lZ7AEbilunCIl3M/vkYfpepAnmTimO9PRmBdoO1Rr+hZcwaL0AnKcahzsH5bqOjMWGg238qIeyza8nhz7FRZOR1F9AaeRIbVxVv0fKwp+nu9OYgjH/J8CjRp2QLu+wCrHHTctSQs+2USzcQ=
Message-ID: <605adbb05081908137d6c8ed7@mail.gmail.com>
Date: Fri, 19 Aug 2005 23:13:11 +0800
From: gnome boxer <gnome.boxer@gmail.com>
To: roucaries bastien <roucaries.bastien@gmail.com>
Subject: Re: kernel 2.6.10-2.6.13-rc4 hang reboot from linux(not from windows or from BIOS),but 2.6.8 and 2.6.9 haven't
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <195c7a900508190807504a988a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <605adbb05081907323d3bd70c@mail.gmail.com>
	 <195c7a900508190807504a988a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/19, roucaries bastien <roucaries.bastien@gmail.com>:
> On 8/19/05, gnome boxer <gnome.boxer@gmail.com> wrote:
> > I use fedora core 4,when I rebooted from linux(not from windows or
> > BIOS),it will hang after the system POST before grub display the stage
> > 1.5 on the screen,so I must reboot again from there using CRTL+ALT+DEL
> >
> > I don't know whether this belongs to grub or belongs to the linux
> > reboot changes from 2.6.8 and 2.6.9
> 
> did you try to add to the kernel command line reboot=cold or
> reboot=bios or reboot=hard.
> 
I tried the reboot=c reboot=b reboot=s

They all have this



> Seems your bios reboot routine is buggy. The preevious option are workarround.

I think it's linux's reboot routine's fault 


> > This only happens in rebooting from Linux kernel within
> > 2.6.10-2.6.13-rc4(not from BIOS or windows).when I use grub to handle
> > boot ,the grub will hang after the system POST,must reboot again from
> > BIOS to boot correct in the grub menu.
> >
> >
> > It only happened *reboot* from Linux,if I directly cold boot
> > everything is ok,or if I reboot from windows it 's booted ok also
> >
> >
> > I tested the older kernel version from 2.6.13-rc4 to 2.6.8 .I found
> > the 2.6.8 and the 2.6.9 worked well without above
> > reboot_from_linux_with_hang_after_POST,and the 2.6.10-2.6.13-rc4 were
> > all have
> >
> > The motherboard is GIGABYTE GA8IPE-1000 ,865PE chipset INTEL ICH5R,
> > prescott 3.0E
> >
> >
> > I wait somebody to report this bug  for a long time and to be fixed
> > but seldom people meet and seems like none fix this.
> >
> > My kernel config and dmesg in the attachment
> Bastien
> >
>

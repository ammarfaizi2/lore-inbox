Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271832AbRHUTBa>; Tue, 21 Aug 2001 15:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271834AbRHUTBU>; Tue, 21 Aug 2001 15:01:20 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:23815 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S271824AbRHUTBK>; Tue, 21 Aug 2001 15:01:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Startup Delay
In-Reply-To: <9lu1js$s3o$1@ns1.clouddancer.com>
In-Reply-To: <027001c12a5b$e5d29be0$160e10ac@hades> <9lu1js$s3o$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010821190122.E5A107840B@mail.clouddancer.com>
Date: Tue, 21 Aug 2001 12:01:22 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>Hello!
>
>I am setting up a server with 4 SCSI hard disks, two of which I will jumper
>to have a delayed spin up as to not bake the power supply.  These two drives
>will contain a striping RAID.  I am concerned that the kernel will load off
>of the other drives and attempt to start this RAID before the disks have
>even spun up - is there a way to have the kernel delay its startup for a
>certain number of seconds while all the drives spin up?
>
>Any hints are greatly appreciated.


You will find that the BIOS will wait for the drive spin up.  I use 9
drives and power 'on' takes a few minutes.  Additionally, the control
electronics is active on the drives, which would delay any attempt to
start RAID.



-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."


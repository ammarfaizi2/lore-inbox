Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271168AbTGPWU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271161AbTGPWU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:20:27 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:50333
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S271176AbTGPWSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:18:45 -0400
Message-ID: <3F15D2C0.2020804@tupshin.com>
Date: Wed, 16 Jul 2003 15:33:36 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030710
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: LVM2 user space, device mapper, Linux 2.4/2.6 dual boot no-go.
References: <20030716095321.GF27177@merlin.emma.line.org>
In-Reply-To: <20030716095321.GF27177@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>Ok,
>
>here's the situation:
>
>I want to test drive 2.6, have 2.4.22-pre3-ac1 with LVM1, Device Mapper
>and XFS. I tried LVM2 user space on 2.4.22, it complained about ioctl
>mismatch (wants 4.x.y, gets 1.m.n). Do I need to disable LVM1?
>
>On 2.6, lvm lvmdiskscan works, but lvm vgscan stuffs my screen with
>"modprobe junk.", so I reverted to 2.4-with-LVM1-user-space for now.
>
>Has anyone had success with running the same user-space LVM2 stuff on
>2.4 and 2.6? Which versions of device-mapper and LVM2 do you use for
>that purpose? What are the magic switches in Linux-2.4.22-preX-acY?
>
>Help appreciated.
>
>  
>
I'm running LVM2 on 2.4.21-ac4, and that works just fine for me (debian 
sid, with the lvm2 package from the distribution). While 2.5/6 is still 
too unstable for me to use for long (for unrelated reasons) , it does 
boot up correctly and function with 25 lvm2 partitions on four different 
lvm groups. I would get it working correctly on your 2.4 kernel first. 
There were not magic incantations for me...what distribution are you 
using, and where are you getting LVM2 from?

-Tupshin


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSFTNPi>; Thu, 20 Jun 2002 09:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSFTNPh>; Thu, 20 Jun 2002 09:15:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2470 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S314395AbSFTNPh>;
	Thu, 20 Jun 2002 09:15:37 -0400
Date: Thu, 20 Jun 2002 15:13:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manik Raina <manik@cisco.com>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
In-Reply-To: <3D1183AF.BCEE2BDF@cisco.com>
Message-ID: <Pine.LNX.4.44.0206201512110.2536-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jun 2002, Manik Raina wrote:

> Ingo,
> 	A small doubt, 
> 	Should'nt this function below return something ? 
> 	set_task_cpu() should return unsigned int but it
> 	seems to do nothing ....

it's a NOP on UP. On SMP it changes p->thread_info->cpu.

	Ingo



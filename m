Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbSLPNn0>; Mon, 16 Dec 2002 08:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSLPNn0>; Mon, 16 Dec 2002 08:43:26 -0500
Received: from opengfs.tovarcom.com ([65.67.58.21]:8382 "HELO
	escalade.vistahp.com") by vger.kernel.org with SMTP
	id <S265650AbSLPNnY>; Mon, 16 Dec 2002 08:43:24 -0500
Message-ID: <20021216135453.3823.qmail@escalade.vistahp.com>
References: <FKEAJLBKJCGBDJJIPJLJEEKMDLAA.scott@coyotegulch.com>
In-Reply-To: <FKEAJLBKJCGBDJJIPJLJEEKMDLAA.scott@coyotegulch.com>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
To: "Scott Robert Ladd" <scott@coyotegulch.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo and hyperthreading
Date: Mon, 16 Dec 2002 07:54:53 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You could always boot once with nosmp and run some benchmarks and then 
reboot (with smp) and run some more benchmarks, and see if there is a 
difference. 

 --Brian Jackson 


Scott Robert Ladd writes: 

> Zwane Mwaikambo wrote:
>> It's ok.
> 
> I'm not so sure. 
> 
> To get the most benefit from two logical CPUs, don't I need the kernel to
> operate as a 2-CPU SMP system? 
> 
> Windows XP initializes the system as SMP with two CPUs; when I run an OpenMP
> application under Windows, it reports two CPUs and a maximum of two threads.
> Under Linux, 
> 
> Linux SMP should initialize based on the number of logical CPUS, not the
> physical number of ships; thus, I should be seeing two CPUs in
> /proc/cpuinfo, not one. 
> 
> ..Scott 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276601AbRJGTV7>; Sun, 7 Oct 2001 15:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276611AbRJGTVt>; Sun, 7 Oct 2001 15:21:49 -0400
Received: from [209.250.53.107] ([209.250.53.107]:35845 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S276601AbRJGTVj>; Sun, 7 Oct 2001 15:21:39 -0400
Date: Sun, 7 Oct 2001 14:12:05 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Willem Riede <wriede@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan Tiger MP AMD760 chipset support
Message-ID: <20011007141205.B4000@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Willem Riede <wriede@home.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011007132349.A1424@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011007132349.A1424@linnie.riede.org>; from wriede@home.com on Sun, Oct 07, 2001 at 01:23:49PM -0400
X-Uptime: 10:19am  up 10:59,  0 users,  load average: 1.09, 1.06, 1.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 01:23:49PM -0400, Willem Riede wrote:
> with reference to AMD760 (IDE?) support on a Tyan K7 Thunder,
> I was somewhat surprised to find the chipset:
> 
>  	AMD-762 North bridge & AMD-766 South bridge
> 	Winbond W83627HF Super I/O ASIC
>  	Winbond W83782D hardware monitoring ASIC
> 
> only partly recognized by my 2.4.9ac18 based kernel. 
> One problem is that the temperature sensors are not detected 
> (I'm reluctant to torture my system if I can't watch out for 
> it overheating).
> 
> Does anyone know the AMD760 support status? Any pointers
> for (experimental) patches?

Look into the lm_sensors patch; it supports many such hardware
monitoring chips, and I believe that yours is one of them.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell
Those that would give up a necessary freedom for temporary safety
deserver neither freedom nor safety.
			-- Ben Franklin

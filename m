Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313975AbSDQASG>; Tue, 16 Apr 2002 20:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313976AbSDQASF>; Tue, 16 Apr 2002 20:18:05 -0400
Received: from ns.crrstv.net ([209.128.25.4]:41373 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S313975AbSDQASF>;
	Tue, 16 Apr 2002 20:18:05 -0400
Date: Tue, 16 Apr 2002 21:18:18 -0300
From: "skidley" <skidley@crrstv.net>
To: Khalid Aziz <khalid_aziz@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre7
Message-ID: <20020417001818.GA9379@crrstv.net>
Mail-Followup-To: Khalid Aziz <khalid_aziz@hp.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0204160049130.18896-100000@freak.distro.conectiva> <slrnabnps8.evm.kraxel@bytesex.org> <20020416200032.14fbd436.lkml@bigpond.com> <20020416123549.A16359@bytesex.org> <3CBC81DF.FC060062@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 01:56:15PM -0600, Khalid Aziz wrote:
> I broke this with a typo in my patch (I inserted a line one line above
> where I wanted to). Follwing patch will fix the problem.
> 
> --
> Khalid
> 
> --- linux-2.4.18-hcdpold/include/asm-i386/serial.h      Tue Apr 16
> 12:05:27 2002
> +++ linux-2.4.18-hcdp/include/asm-i386/serial.h Tue Apr 16 12:02:54 2002
> @@ -140,8 +140,8 @@
>  #endif
>  
>  #define SERIAL_PORT_DFNS               \
> -       HCDP_SERIAL_PORT_DEFNS          \
>         STD_SERIAL_PORT_DEFNS           \
> +       HCDP_SERIAL_PORT_DEFNS          \
>         EXTRA_SERIAL_PORT_DEFNS         \
>         HUB6_SERIAL_PORT_DFNS           \
>         MCA_SERIAL_PORT_DFNS
> 
> 
> 
> 
failed against 2.4.19-pre7 here
-- 
Chad Young
Linux User #195191 

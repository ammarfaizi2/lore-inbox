Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290561AbSBFOVf>; Wed, 6 Feb 2002 09:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290565AbSBFOVZ>; Wed, 6 Feb 2002 09:21:25 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:53001 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S290561AbSBFOVL>;
	Wed, 6 Feb 2002 09:21:11 -0500
Subject: Re: Intel Speedstep bug in 2.4.17?
From: Shaya Potter <spotter@cs.columbia.edu>
To: lathi@seapine.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <87eljzb8l6.fsf@localhost.localdomain>
In-Reply-To: <87eljzb8l6.fsf@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Feb 2002 09:20:48 -0500
Message-Id: <1013005249.15711.1.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have similiar issues on my t21.

when I boot without AC it says my mhz is < 200mhz (while I believe it
should be 650, as opposed to the full 800)

shaya potter

On Tue, 2002-02-05 at 22:19, Doug Alcorn wrote:
> I have an IBM Thinkpad A22m with an Intel Pentium III (Coppermine)
> 800Mhz.  I custom compiled a 2.4.17 kernel.  I'm also using Sawfish
> 1.0.1-6.  I have a problem with the mouse input in my XFree86 4.1.0.
> Sometimes it doesn't register mouse clicks (requiring me to click
> three or four times).  Also, the focus follows mouse seems off.
> Most times I have to move the mouse in and out of a window several
> times before the focus actually switches.  I originally thought this
> was a bug in sawfish, so I asked there.  They said it was actually a
> kernel issue.  I'm not sure I really understand that; however, when I
> boot the machine with the AC plugged in I never see these symptoms.
> If I boot the machine on battery power the symptoms show up right
> away.  Also, if I boot on AC but later suspend and then resume on
> battery power I don't see any of the symptoms.  Can anyone shed any
> light on this?  Is it a known issue?  Is it fixable?
> 
> Here are my APM configuration variables for my kernel:
> 
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_RTC_IS_GMT=y
> CONFIG_APM_ALLOW_INTS=y
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> # CONFIG_ACPI is not set
> 
> -- 
>  (__) Doug Alcorn (mailto:doug@lathi.net http://www.lathi.net)
>  oo / PGP 02B3 1E26 BCF2 9AAF 93F1  61D7 450C B264 3E63 D543
>  |_/  If you're a capitalist and you have the best goods and they're
>       free, you don't have to proselytize, you just have to wait. 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



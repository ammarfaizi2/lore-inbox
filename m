Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276552AbRJGS0B>; Sun, 7 Oct 2001 14:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276558AbRJGSZw>; Sun, 7 Oct 2001 14:25:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22773 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S276552AbRJGSZn>; Sun, 7 Oct 2001 14:25:43 -0400
Message-ID: <3BC09DB5.279ED948@mvista.com>
Date: Sun, 07 Oct 2001 11:23:49 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Igor Mozetic <igor.mozetic@uni-mb.si>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac4 (SMP, highmem) complete freeze
In-Reply-To: <15293.65326.541017.774801@cmb1-3.dial-up.arnes.si>
		<Pine.LNX.4.21.0110051436560.2744-100000@freak.distro.conectiva>
		<15294.1922.204820.340222@cmb1-3.dial-up.arnes.si> <15294.2287.812821.556092@cmb1-3.dial-up.arnes.si>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Mozetic wrote:
> 
> Marcelo Tosatti writes:
> 
>  > Can you try to get any backtraces the next time the machine locks up ?
>  >
>  > You can use the SysRQ key's for that (documentation about it at
>  > Documentation/sysrq.txt). (Alt+SysRQ+T and Alt+SysRQ+P traces)
> 
> Well, at the time of this lockup I was in almost on-line contact
> with Ingo and we couldn't get anything at all! Screen was dead blank,
> no keystroke worked, NumLock didn't work, even Power Off didn't work.
> Also, nothing over netconsole. If you have any other suggestion,
> please ...

Did you turn on the NMI watchdog?  See
.../linux/Documentation/nmi_watchdog.txt in your kernel tree.

George
> 
> I'm now back to 2.4.3 (which worked reliably for months)
> just to make sure that the hardware is OK.
> But I strongly suspect kernel, because these deadlock
> coincide with 2.4.10 and I don't believe in coincidences.
> 
> -Igor Mozetic
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTKSFoR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 00:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTKSFoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 00:44:17 -0500
Received: from CPE-138-130-214-20.qld.bigpond.net.au ([138.130.214.20]:25037
	"EHLO mx.jeeves.bpa.nu") by vger.kernel.org with ESMTP
	id S263851AbTKSFoO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 00:44:14 -0500
From: Ben Hoskings <ben@jeeves.bpa.nu>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 yenta_socket eats kernel time on Toshiba Laptop
Date: Wed, 19 Nov 2003 15:44:11 +1000
User-Agent: KMail/1.5.4
References: <15270833.1069152610368.JavaMail.ngmail@webmail06.arcor-online.net> <200311182243.18614.ben@jeeves.bpa.nu>
In-Reply-To: <200311182243.18614.ben@jeeves.bpa.nu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200311191544.11948.ben@jeeves.bpa.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,
tried to send this directly but your ISP seems to be blocking my mail for some 
reason. I'll investigate that, but here's the message for now.

Thanks again

On Tue, 18 Nov 2003 10:43 pm, I wrote:
> On Tue, 18 Nov 2003 08:50 pm, thomas.mey3r@arcor.de wrote:
> > Hi Ben,
> >
> > can you send me your /proc/interrupts?
>
> No problem.
>
> 2.4.22:
>            CPU0
>   0:      22858          XT-PIC  timer
>   1:        443          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:        318          XT-PIC  xirc2ps_cs
>   8:          2          XT-PIC  rtc
>   9:         70          XT-PIC  acpi
>  11:      13375          XT-PIC  ymfpci
>  12:       7049          XT-PIC  PS/2 Mouse
>  14:       9969          XT-PIC  ide0
>  15:          9          XT-PIC  ide1
> NMI:          0
> LOC:          0
> ERR:          0
> MIS:          0
>
>
> 2.6.0-test9:
>            CPU0
>   0:      70126          XT-PIC  timer
>   1:        201          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   8:          2          XT-PIC  rtc
>   9:         30          XT-PIC  acpi
>  11:          0          XT-PIC  YMFPCI
>  12:         58          XT-PIC  i8042
>  14:       6855          XT-PIC  ide0
>  15:          9          XT-PIC  ide1
> NMI:          0
> LOC:          0
> ERR:          0
> MIS:          0
>
> If there's anything else that'd be useful, give me a yell.
>
> > with kind regards
> > Thomas Meyer
>
> Cheers,
> Ben Hoskings
>
> > ----- Original Nachricht ----
> > Von:     Ben Hoskings <ben@jeeves.bpa.nu>
> > An:      linux-kernel@vger.kernel.org
> > Datum:   18.11.2003 10:24
> > Betreff: Re: 2.6.0 yenta_socket eats kernel time on Toshiba Laptop
> >
<snip> for brevity
> > >
> > > Anyone else have any suggestions on what I could do to start debugging
> > > this
> > > problem? I don't like to ask again, but I figure this is too good a
> > > chance to
> > > miss.
> > > I'd like to get my laptop working with 2.6, sure, but more importantly
> > > a problem like this that affects hardware I own is the perfect chance
> > > for me to
> > > poke my head into the kernel sources and start learning. ;)
> > >
> > >
> > > ben_h
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/


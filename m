Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286724AbRL1DtO>; Thu, 27 Dec 2001 22:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286728AbRL1DtD>; Thu, 27 Dec 2001 22:49:03 -0500
Received: from [212.50.10.141] ([212.50.10.141]:52168 "HELO ns.top.bg")
	by vger.kernel.org with SMTP id <S286724AbRL1Dsz>;
	Thu, 27 Dec 2001 22:48:55 -0500
Message-ID: <3C2C786F.42B709A@top.bg>
Date: Fri, 28 Dec 2001 05:49:35 -0800
From: Anton Tinchev <atl@top.bg>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
In-Reply-To: <Pine.LNX.4.33.0112271443100.8153-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After few months of problems with eepro with the following hardware

Intel STL2 (Serverworks III LE) Mainboard
and
Asus CUVX-D (via 694D chipset)

I trashed the cards and now using 3C905

There're several problems with the stability of drivers in eepro drivers
May be the problem is lack of low level decumentation for the cards
They advise to use their binnary only driver (did you? :)).


Zwane Mwaikambo wrote:

> The oldest kernel i've tried is 2.4.10-ac11 on my SMP box and my
> mysterious "hangs" (10-20s at a time) disappeared when i switched to
> 2.4.17-pre2. The box is dual P3 on Serverworks LE chipset. I tried
> switching cards from the onboard eepro100 to a seperate dual eepro100 card
> and that also exhibited the same problems, so there *might* be something
> with the driver. Currently i'm using 3c59x, but i can still test with the
> onboard eepro100, let me know if you need guinea pigs.
>
> Cheers,
>         Zwane Mwaikambo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


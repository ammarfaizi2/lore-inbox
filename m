Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286826AbRL1KnW>; Fri, 28 Dec 2001 05:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286833AbRL1KnN>; Fri, 28 Dec 2001 05:43:13 -0500
Received: from [212.50.10.141] ([212.50.10.141]:48074 "HELO ns.top.bg")
	by vger.kernel.org with SMTP id <S286826AbRL1KnE>;
	Fri, 28 Dec 2001 05:43:04 -0500
Message-ID: <3C2CD97C.A0B9FCF2@top.bg>
Date: Fri, 28 Dec 2001 12:43:40 -0800
From: Anton Tinchev <atl@top.bg>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
In-Reply-To: <Pine.LNX.4.33.0112281234260.29899-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is with the kernel driver - i locks under heavy load (over 2
000-3 000 packet/s, may be less).
Change the card if you can, i didn't recommend you this card for production
server.
Cheers

Zwane Mwaikambo wrote:

> >There're several problems with the stability of drivers in eepro drivers
> >May be the problem is lack of low level decumentation for the cards
> >They advise to use their binnary only driver (did you? :)).
>
> I used the kernel driver, binary only drivers are a royal pain.
>
> Cheers,
>         Zwane Mwaikambo


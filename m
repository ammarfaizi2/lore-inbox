Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311085AbSCHU2x>; Fri, 8 Mar 2002 15:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311082AbSCHU2o>; Fri, 8 Mar 2002 15:28:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27152 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311078AbSCHU2b>; Fri, 8 Mar 2002 15:28:31 -0500
Subject: Re: gettimeofday() system call timing curiosity
To: root@chaos.analogic.com
Date: Fri, 8 Mar 2002 20:43:13 +0000 (GMT)
Cc: johan.adolfsson@axis.com, lk@tantalophile.demon.co.uk (Jamie Lokier),
        hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        terje.eggestad@scali.com (Terje Eggestad),
        greearb@candelatech.com (Ben Greear),
        davidel@xmailserver.org (Davide Libenzi),
        george@mvista.com (george anzinger)
In-Reply-To: <Pine.LNX.3.95.1020308143013.6910A-100000@chaos.analogic.com> from "Richard B. Johnson" at Mar 08, 2002 02:45:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jRCr-0007R7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try it. It doesn't matter. Alan was correct, my computer sucks. However,
> they won't give me a 10 GHz one (yet). Note that although gettimeofday()

On a 1.8GHz athlon the "same" case occurs almost all the time. Machines
without a TSC will probably never hit it due to the slow ISA transactions
to talk to the PIT

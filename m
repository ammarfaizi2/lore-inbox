Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131745AbRAJKfL>; Wed, 10 Jan 2001 05:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131934AbRAJKfB>; Wed, 10 Jan 2001 05:35:01 -0500
Received: from v25.hebdomag.com ([207.253.212.25]:62218 "EHLO trader-tcp.com")
	by vger.kernel.org with ESMTP id <S131745AbRAJKey>;
	Wed, 10 Jan 2001 05:34:54 -0500
Message-ID: <3A5C3BAB.F071EB67@trader.com>
Date: Wed, 10 Jan 2001 11:38:35 +0100
From: Joseph Bueno <joseph.bueno@trader.com>
X-Mailer: Mozilla 4.73 [fr] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gábor Lénárt <lgb@vega.digitel2002.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: pretending a network interface
In-Reply-To: <20010110103320.B13083@vega.digitel2002.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gábor Lénárt a écrit :
> 
> Hi,
> 
> Is it possible somehow for a process to pretending a functional network
> interface? I mean some emulator I develope requires to have network
> capability. On the real machine it will run it has got serial interface
> to connect to PC. But I develope it under Linux first, and I try to
> test it. It would be cool to have something which can be fed by data and
> trasmit it as it come from a network interface. According for example vice,
> it is possible to use a serial port, which is linked to another serial port
> of the same machine. But this is ugly and I haven't got two free serial
> port either.
> 
> - Gabor
> 
> --
>  --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]--[ lgb@supervisor.hu ]--
>  U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
>  -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Hi,

I don't really understand what you mean with "a process to pretending a
functional network interface". If you are looking for a way to have
something
that looks like a network interface without real hardware, you should
look at "dummy" module.

On ma machine, I use:

ifconfig dummy0 192.168.1.1 up

to set up such an interface.

Hope this helps
--
Joseph Bueno
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

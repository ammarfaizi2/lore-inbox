Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131181AbQKUUFy>; Tue, 21 Nov 2000 15:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131198AbQKUUFo>; Tue, 21 Nov 2000 15:05:44 -0500
Received: from [64.64.109.142] ([64.64.109.142]:49419 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131181AbQKUUFe>; Tue, 21 Nov 2000 15:05:34 -0500
Message-ID: <3A1ACE5E.E5796CE1@didntduck.org>
Date: Tue, 21 Nov 2000 14:34:54 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <Pine.GSO.3.96.1001121195742.28403E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> On Tue, 21 Nov 2000, Alan Cox wrote:
> 
> > Quite a few dual pentium socket 7 boards report dual cpu and apic in the
> > MP table regardless of the capabilities of the CPU installed. Its apparently
> > legal to do so. There is an apic capability flag that should be tested before
> 
>  It's not legal -- the MPS is very explicit the MP-table must reflect a
> real configuration.

Legal or not, there are broken BIOSes out there.  I had a Tyan Tomcat 4S
that exhibited this behavior.  Even though it was a single socket board,
it had the same BIOS as the 4D (dual socket version) and would crash on
an SMP kernel with a K6.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSBWWTm>; Sat, 23 Feb 2002 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293220AbSBWWTb>; Sat, 23 Feb 2002 17:19:31 -0500
Received: from ns.ithnet.com ([217.64.64.10]:13071 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288071AbSBWWTM>;
	Sat, 23 Feb 2002 17:19:12 -0500
Date: Sat, 23 Feb 2002 23:18:50 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: adam@os.inf.tu-dresden.de, fernando@quatro.com.br,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-Id: <20020223231850.4ea9d3ca.skraw@ithnet.com>
In-Reply-To: <E16efs1-0005cE-00@the-village.bc.nu>
In-Reply-To: <20020223173857.3db89749.skraw@ithnet.com>
	<E16efs1-0005cE-00@the-village.bc.nu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002 17:22:01 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > <4>CPU1<T0:1339376,T1:446448,D:8,S:446460,C:1339380>
> > <4>checking TSC synchronization across CPUs: passed.
> > <4>Waiting on wait_init_idle (map = 0x2)
> > <4>All processors have done init_idle
> > 
> > I would say this means the TSC skew fix is broken and shooting down your box. What do you think, Alan?
> 
> Seems a reasonable guess. However that TSC skew itself may point to other
> problems. It means one processor started running successfully a little after
> the other. That might be normal behaviour for that board or might point to 
> something else 

It seems no normal behaviour, I checked several other boards of this type and none had a TSC skew (and all work). Purely guessing I would suggest two try some other 2 processors to verify the behaviour is really processor-independent. Another guess would of course be the MB itself being broken to some extent.

Has anybody ever seen a _working_ skew correction? Is this known-to-work code?

Regards,
Stephan


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbQKQPBA>; Fri, 17 Nov 2000 10:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129442AbQKQPAu>; Fri, 17 Nov 2000 10:00:50 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:30681 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129216AbQKQPAp>; Fri, 17 Nov 2000 10:00:45 -0500
From: Christoph Rohland <cr@sap.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <Pine.LNX.4.21.0011171400550.8383-100000@saturn.homenet>
Organisation: SAP LinuxLab
Date: 17 Nov 2000 15:30:26 +0100
In-Reply-To: Tigran Aivazian's message of "Fri, 17 Nov 2000 14:02:29 +0000 (GMT)"
Message-ID: <qwwsnoqu0vx.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tigran,

On Fri, 17 Nov 2000, Tigran Aivazian wrote:
> On Fri, 17 Nov 2000, Andi Kleen wrote:
>> [of course rdtsc only works properly on UP or with bind_cpu()]
> 
> I thought Linux kernel does synchronize them on boot? So, you are
> saying I cannot rely on this being 100% correct?

Yes, it does so far. And if we cannot assume this to be correct in the
microsecond scale on smp machines with homogenous non-powersaving cpus
we will loose on some benchmarks. So far it works on all our servers.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275806AbRJJOC6>; Wed, 10 Oct 2001 10:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275813AbRJJOCs>; Wed, 10 Oct 2001 10:02:48 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:26098 "HELO
	giants.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S275806AbRJJOCj>; Wed, 10 Oct 2001 10:02:39 -0400
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>,
        linux-kernel@vger.kernel.org
Subject: Re: APM on a HP Omnibook XE3
In-Reply-To: <200108301443355.SM00167@there> <m2elobn7a3.fsf@anano.mitica>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 10 Oct 2001 16:02:23 +0200
In-Reply-To: <m2elobn7a3.fsf@anano.mitica> (Juan Quintela's message of "10 Oct 2001 12:01:08 +0200")
Message-ID: <m3sncrh9u8.fsf@giants.mandrakesoft.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juan Quintela <quintela@mandrakesoft.com> writes:

> >>>>> "robert" == Robert Szentmihalyi <robert.szentmihalyi@entracom.de> writes:
> 
> robert> Hi!
> robert> Sorry if this is OT.
> robert> I'm not sure if this is a kernel issue, but I'm running out of 
> robert> ideas on this....
> 
> robert> I have a HP Omnibook XE3 with SuSE Linux 7.2 installed.
> robert> Everything works fine except suspend-to-disk.
> robert> (I have created the partition. It works under Winblows...)
> robert> I have tried Kernels 2.4.4 and 2.4.7 (with SuSE patches) as well as 
> robert> 2.4.9 vanilla, but I keep getting the same messages:
> robert> When I do
> robert> apm -s
> robert> I get 
> robert> apm: Input/output error
> robert> and the Kernel log says:
> robert> apm: suspend: Unable to enter requested state
> 
> 
> robert> Any ideas what I could do?
> 
> For me Fn+F12 works.
> apm -s & apm -S fails.

works only if you have a suspend-on-disk partition.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271187AbRHTKfP>; Mon, 20 Aug 2001 06:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271192AbRHTKfF>; Mon, 20 Aug 2001 06:35:05 -0400
Received: from krynn.axis.se ([193.13.178.10]:21635 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S271187AbRHTKes>;
	Mon, 20 Aug 2001 06:34:48 -0400
Message-ID: <21a701c12963$bcb05b60$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: "Martin Dalecki" <dalecki@evision-ventures.com>,
        "Robert Love" <rml@tech9.net>
Cc: "Oliver Xymoron" <oxymoron@waste.org>, <linux-kernel@vger.kernel.org>,
        <riel@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org> <998193404.653.12.camel@phantasy> <3B80E01B.2C61FF8@evision-ventures.com>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Date: Mon, 20 Aug 2001 12:34:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Dalecki <dalecki@evision-ventures.com> wrote:
> I think you are just wrong - nobody really needs this patch. /dev/random
> or /dev/urandom ar *both* anyway just complete overkill in terms of
> practical security. /dev/urandom is in esp silly, since it is providing
> a md5 hash implementation inside the kernel, which could be *compleatly*
and
> entierly done inside user land.

And I think you are wrong, this patch is needed.
Keep up the good work Robert!

> You mean - there is no known algorithm with polynomial time
> behaviour enabling us to calculate the next value of this function
> from the previous ones - Not more nor less - no pysics and
> entropy involved. If you assume this holds true it's mathematically
> entierly sufficient that a single only seed value is not known.

Where would you get the single seed from in an embedded head
less system if you don't have a hardware random generator,
no disk and don't seed it from the network interrupts?

I think the patch makes sense - let people have the config option.

/Johan




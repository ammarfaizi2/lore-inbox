Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286925AbSABKzb>; Wed, 2 Jan 2002 05:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286928AbSABKzV>; Wed, 2 Jan 2002 05:55:21 -0500
Received: from dns.logatique.fr ([213.41.101.1]:7671 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S286925AbSABKzL>; Wed, 2 Jan 2002 05:55:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Momchil Velikov <velco@fadata.bg>,
        Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] mesh: target 0 aborted
Date: Wed, 2 Jan 2002 12:17:51 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20020101234546.GO28513@cpe-24-221-152-185.az.sprintbbd.net> <20020102091710.14178@smtp.noos.fr>
In-Reply-To: <20020102091710.14178@smtp.noos.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020102105250.8AE1323CBB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 10:17, Benjamin Herrenschmidt wrote:
> The other patch for getting rid of "target 0 aborted" need some more
> review. You seem to just remove the bus reset. That could be made a
> driver option in case it really cause trouble, but I suppose the bug
> is elsewhere (while beeing triggered by the bus reset).
>
> I'll look into this around next week.


	I'm the one responsible for this patch. I can't boot my powerpc7600 whithout 
it. I've been pushing this patch (on the linux-ppc list) for so long (several 
years, don't remember), that I've given up last year.

	Linuxppc people are even worse than Linus. I did not even get an answer 
about a problem with my patch or whatever. Pure 'nothing'. Not even a 'no'.

	I'm still ready to test/discuss about the pb with anybody, anyway.

	Let's get clear about what I've done : I'm using linuxppc for many years, 
and at one point, the kernel refused to boot. I've checked the difference 
between this kernel and the last one I was using, and merely changed back the 
mesh.c so that it works. As I was not following kernel dvpmt very closely by 
then, I can't tell when the change that broke things came in.

	I would be very happy to change my patch so that this change is optional.

happy new year,
Thomas


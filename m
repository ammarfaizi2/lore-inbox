Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbRE3CNi>; Tue, 29 May 2001 22:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbRE3CN2>; Tue, 29 May 2001 22:13:28 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5358 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262568AbRE3CNO>;
	Tue, 29 May 2001 22:13:14 -0400
Message-ID: <3B14572E.47218B5@mandrakesoft.com>
Date: Tue, 29 May 2001 22:13:02 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tori@unhappy.mine.nu,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #9
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl> <20010529180420.A14639@bougret.hpl.hp.com> <3B14493E.63F861E7@mandrakesoft.com> <20010529182506.A14727@bougret.hpl.hp.com> <3B145127.5B173DFF@mandrakesoft.com> <20010529190152.A14806@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*shrug*  Well, if you want to go against the kernel standard that's fine
with me.  I won't put Andrzej's changes to your drivers upstream.  You
are going to continually see patches to clean that up, though, because
it makes the end user's kernel smaller.  Please consider noting this
special case in a comment in each of your drivers "do not clean up
static initializers" or similar.

It's really a pain in the ass to remember special cases like this, so
please reconsider.  Being not-like-the-others is detrimental to the long
term maintainability of the overall kernel.

Regards,

	Jeff


-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |

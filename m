Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265648AbRGCJ3s>; Tue, 3 Jul 2001 05:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbRGCJ3i>; Tue, 3 Jul 2001 05:29:38 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26536 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265648AbRGCJ3b>;
	Tue, 3 Jul 2001 05:29:31 -0400
Message-ID: <3B419078.6397F41C@mandrakesoft.com>
Date: Tue, 03 Jul 2001 05:29:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Jes Sorensen <jes@sunsite.dk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions
In-Reply-To: <4047.994150836@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Of course, however, this still requires cookie decoding to be done in readb
> and writeb (even on the i386). So why not use resource struct?

IMHO that makes the operation too heavyweight on architectures where
that level of abstraction is not needed.

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner

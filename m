Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265390AbRGBS1A>; Mon, 2 Jul 2001 14:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265391AbRGBS0u>; Mon, 2 Jul 2001 14:26:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:56992 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265390AbRGBS0g>;
	Mon, 2 Jul 2001 14:26:36 -0400
Message-ID: <3B40BCDA.CFA5750E@mandrakesoft.com>
Date: Mon, 02 Jul 2001 14:26:34 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, Jes Sorensen <jes@sunsite.dk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions
In-Reply-To: <19921.994092096@redhat.com> <E15H70K-0006Cn-00@the-village.bc.nu> <20010702192227.B29246@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Mon, Jul 02, 2001 at 05:56:56PM +0100, Alan Cox wrote:
> > Case 1:
> >       You pass a single cookie to the readb code
> >       Odd platforms decode it
> 
> Last time I checked, ioremap didn't work for inb() and outb().

It should :)

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner

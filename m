Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283770AbRLXXsF>; Mon, 24 Dec 2001 18:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284009AbRLXXrz>; Mon, 24 Dec 2001 18:47:55 -0500
Received: from hermes.domdv.de ([193.102.202.1]:49929 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S283770AbRLXXrt>;
	Mon, 24 Dec 2001 18:47:49 -0500
Message-ID: <XFMail.20011225004342.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3C27BA0D.58F0A02C@gmx.de>
Date: Tue, 25 Dec 2001 00:43:42 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Edgar Toernig <froese@gmx.de>
Subject: Re: [patch] Assigning syscall numbers for testing
Cc: Benjamin LaHaise <bcrl@redhat.com>, Keith Owens <kaos@ocs.com.au>,
        Doug Ledford <dledford@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24-Dec-2001 Edgar Toernig wrote:
> Russell King wrote:
>> 
>> On Mon, Dec 24, 2001 at 07:05:31PM +0000, Alan Cox wrote:
>> > > it.  However, I think it needs to be allocated *regardless* of whether
>> > > Linus
>> > > takes the patch into his kernel.  Even if the patch is simply used
>> > > outside
>> > > Linus's kernel, it still needs the allocation to truly be safe.
>> >
>> > Negative numbers are safe until Linus has 2^31 syscalls, at which point
>> > quite frankly we would have a few other problems including the fact that
>> > the syscall table won't fit in kernel mapped memory.
>> 
>> Please leave the allocation of the exact number space to the port
>> maintainers discression.
> 
> Why not assign 1 syscall that gets the name of an experimental syscall
> as its first argument and does the demultiplexing?
> 

Please, no multiplexing. A well defined range (small as it may be) open to
developers (and thus collision) will do.

> Ciao, ET.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

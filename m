Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTAaPZb>; Fri, 31 Jan 2003 10:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTAaPZa>; Fri, 31 Jan 2003 10:25:30 -0500
Received: from ns.suse.de ([213.95.15.193]:35858 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261448AbTAaPZ3>;
	Fri, 31 Jan 2003 10:25:29 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 morse code panics
References: <20030131104326.GF12286@louise.pinerecords.com.suse.lists.linux.kernel> <200301311112.h0VBCv00000575@darkstar.example.net.suse.lists.linux.kernel> <20030131132221.GA12834@codemonkey.org.uk.suse.lists.linux.kernel> <1044025785.1654.13.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 31 Jan 2003 16:34:55 +0100
In-Reply-To: Alan Cox's message of "31 Jan 2003 15:20:11 +0100"
Message-ID: <p73hebpqqn4.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Fri, 2003-01-31 at 13:22, Dave Jones wrote:
> > Or you could put down the crackpipe and run a serial console between
> > the two boxes. Or even netconsole would make more sense
> > (and be a lot more reliable).
> 
> A lot of newer laptops do not have serial ports. While morse code may
> be a little silly the general purpose hook  it needs to be done 
> cleanly is considerably more useful

And how many users and how many kernel hackers are able to decode
morse on the fly? Are you going to explain to users
"to debug this you'll need to learn morse" ?

If you want to make debugging easy for laptops write a USB or firewire
console. Firewire is actually quite interesting because it can even
do DMA, so you could peek into the memory.

Morse is not helpful.

I admit I was the on who got this ball running by suggesting it "as an 
exercise for the reader" in the original panic blink code, but
guys this was intended as a JOKE, not serious. Please get over it
and don't merge that silly code.

Thanks,
-Andi

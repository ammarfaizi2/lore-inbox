Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRDTVbC>; Fri, 20 Apr 2001 17:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbRDTVam>; Fri, 20 Apr 2001 17:30:42 -0400
Received: from t2.redhat.com ([199.183.24.243]:46320 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131643AbRDTVad>; Fri, 20 Apr 2001 17:30:33 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010420172435.A21252@thyrsus.com> 
In-Reply-To: <20010420172435.A21252@thyrsus.com>  <Pine.LNX.4.33.0104201440580.12186-100000@xanadu.home> <6817.987801548@redhat.com> 
To: esr@thyrsus.com
Cc: Nicolas Pitre <nico@cam.org>, Tom Rini <trini@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>,
        lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Apr 2001 22:29:00 +0100
Message-ID: <7043.987802140@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



esr@thyrsus.com said:
>  Not good enough.  In a year, the pile of false positives would get
> high enough to make it too hard to spot real bugs like the Aironet
> mismatch.  The whole  point of the cleanup is to be able to mechanize
> the consistency checks so they require a minimum of human judgment.

I'm not sure that's the case. The nature of the false positives is that 
they're generally _temporary_ aberrations, caused by the loss of 
synchronisation of various maintainers w.r.t submitting patches to Linus.

I'd be very surprised if the number of false positives isn't fairly stable, 
with new ones being introduced at a similar rate to the rate at which old 
ones finally become correct. 

Might be interesting to check a few older kernels to see if this is true. 
Actually I might expect it to be roughly proportional to the number of 
separately-maintained bodies of code - so it'll grow over time, as the size 
of the Linux kernel grows. 

--
dwmw2



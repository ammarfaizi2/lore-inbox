Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131418AbQL2Sfb>; Fri, 29 Dec 2000 13:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131772AbQL2SfV>; Fri, 29 Dec 2000 13:35:21 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:40456 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S131418AbQL2SfF>;
	Fri, 29 Dec 2000 13:35:05 -0500
Date: Fri, 29 Dec 2000 20:04:21 +0200
From: Petru Paler <ppetru@ppetru.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jure Pecar <pegasus@telemach.net>, linux-kernel@vger.kernel.org,
        thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229200421.A8543@ppetru.net>
In-Reply-To: <3A4BE9B0.5C809AAC@telemach.net> <20001229032953.A9810@athlon.random> <20001229034712.B9810@athlon.random> <20001229093840.A792@ppetru.net> <20001229165340.C12791@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20001229165340.C12791@athlon.random>; from andrea@suse.de on Fri, Dec 29, 2000 at 04:53:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 04:53:40PM +0100, Andrea Arcangeli wrote:
> On Fri, Dec 29, 2000 at 09:38:40AM +0200, Petru Paler wrote:
> > This is one of the main thttpd design points: run in a select() loop. Since
> > it is intended for mainly static workloads, it performs quite well...
> 
> It can't scale in SMP.

No one said it does, but it works nicely on UP.

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

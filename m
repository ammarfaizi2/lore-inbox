Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131628AbRAGM4A>; Sun, 7 Jan 2001 07:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131622AbRAGMzu>; Sun, 7 Jan 2001 07:55:50 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:44579 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S131476AbRAGMzm>; Sun, 7 Jan 2001 07:55:42 -0500
Date: Sun, 7 Jan 2001 14:55:22 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Andre Tomt <andre@tomt.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jim@browsermedia.com
Subject: Re: Which kernel fixes the VM issues?
Message-ID: <20010107145522.K1265@niksula.cs.hut.fi>
In-Reply-To: <20010107140607.J1265@niksula.cs.hut.fi> <OPECLOJPBIHLFIBNOMGBKENCCHAA.andre@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OPECLOJPBIHLFIBNOMGBKENCCHAA.andre@tomt.net>; from andre@tomt.net on Sun, Jan 07, 2001 at 01:47:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 01:47:39PM +0100, you [Andre Tomt] claimed:
> > > This issue is fixed in 2.2.18 AFAIK (never seen it since).
> >
> > Nope.
> >
> > It's fixed 2.2.19pre2 (which includes the Andrea Arcangeli's vm-global-7
> > patch that (among other things) fixes this.)
> 
> I stand corrected. Still, with almost-vanilla 2.2.18 (+ ow patches) on a
> highly loaded webserver has not shown any "LRU block list corruption"
> crashes in over 6 weeks, even when it usually died after a week on 2.2.17
> with the same error (if memory serves me right). Could be the system tuning
> that has "fixed" this by making the usual load not - err - load the server
> as much as before.

I'm not sure about the "LRU block list" thing (it may be another issue),
but AFAIK it's vm-global that fixes the try_to_free_pages thing. It's also
my experience, that the try_to_free_pages is completely gone after
applying vm-global to otherwise identical 18pre.
 
> > You can also apply the vm-global-patch to 2.2.18 if you like.
> 
> Yep, as stated in my previous mail :-)


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

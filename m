Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130212AbRBFTrh>; Tue, 6 Feb 2001 14:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130047AbRBFTr1>; Tue, 6 Feb 2001 14:47:27 -0500
Received: from chiara.elte.hu ([157.181.150.200]:35594 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130023AbRBFTrP>;
	Tue, 6 Feb 2001 14:47:15 -0500
Date: Tue, 6 Feb 2001 20:46:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061402200.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.30.0102062045350.8926-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Ben LaHaise wrote:

> > > You mentioned non-spindle base io devices in your last message.  Take
> > > something like a big RAM disk. Now compare kiobuf base io to buffer
> > > head based io. Tell me which one is going to perform better.
> >
> > roughly equal performance when using 4K bhs. And a hell of a lot more
> > complex and volatile code in the kiobuf case.
>
> I'm willing to benchmark you on this.

sure. Could you specify the actual workload, and desired test-setups?

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

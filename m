Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132951AbRDJHr7>; Tue, 10 Apr 2001 03:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132952AbRDJHrt>; Tue, 10 Apr 2001 03:47:49 -0400
Received: from t2.redhat.com ([199.183.24.243]:22266 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S132951AbRDJHrk>; Tue, 10 Apr 2001 03:47:40 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores 
In-Reply-To: Your message of "Mon, 09 Apr 2001 22:43:53 PDT."
             <Pine.LNX.4.31.0104092242320.11520-100000@penguin.transmeta.com> 
Date: Tue, 10 Apr 2001 08:47:34 +0100
Message-ID: <8623.986888854@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since you're willing to use CMPXCHG in your suggested implementation, would it
make it make life easier if you were willing to use XADD too?

Plus, are you really willing to limit the number of readers or writers to be
32767? If so, I think I can suggest a way that limits it to ~65535 apiece
instead...

David

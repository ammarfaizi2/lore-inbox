Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272135AbRIRP0N>; Tue, 18 Sep 2001 11:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272122AbRIRP0D>; Tue, 18 Sep 2001 11:26:03 -0400
Received: from t2.redhat.com ([199.183.24.243]:17658 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272118AbRIRPZw>; Tue, 18 Sep 2001 11:25:52 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: manfred@colorfullife.com (Manfred Spraul),
        andrea@suse.de (Andrea Arcangeli),
        torvalds@transmeta.com (Linus Torvalds), dhowells@redhat.com,
        Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Your message of "Tue, 18 Sep 2001 15:49:11 BST."
             <E15jMBT-00011x-00@the-village.bc.nu> 
Date: Tue, 18 Sep 2001 16:26:11 +0100
Message-ID: <6460.1000826771@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Okay preliminary as-yet-untested patch to cure coredumping of the need> to 
> >hold the mm semaphore:
>
> If you want codd for this its in the older -ac tree. Linus decided it wasnt
> justified so it went out

Arjan said there was such a beast in the -ac stuff, but I guess this explains
why I couldn't find it... Do you have any idea which -ac's?

Oh well, I'd already done my patch anyway. Does it look okay to you.

David

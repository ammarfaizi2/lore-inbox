Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbVKBOpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVKBOpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVKBOpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:45:06 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:63260 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965059AbVKBOpE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:45:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CiqZO6r/U6JJ+TIu6t+ukFuNyjMyfnZbT8kqrzolXWG4JtI85v+s3CDspNp1QPuJR8wvRdZbTbDLnVi3U0gucYnWfuWRHO1yJm7FPi/5GJ/jgjQ3rEjRGau+KJVsf0Ev8nkkkNq97Ppz7w2AHQoW7+zLhaIG4gd4u5bnHqLy1gs=
Message-ID: <cb2ad8b50511020645i23c164d4h7140c4c352159974@mail.gmail.com>
Date: Wed, 2 Nov 2005 09:45:03 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rt1
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051102144015.GA19845@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051030133316.GA11225@elte.hu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
	 <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
	 <1130900716.29788.22.camel@localhost.localdomain>
	 <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
	 <1130902342.29788.23.camel@localhost.localdomain>
	 <cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com>
	 <20051102102116.3b0c75d1@mango.fruits.de>
	 <cb2ad8b50511020635qb355f33w6f3638972556c242@mail.gmail.com>
	 <20051102144015.GA19845@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Carlos Antunes <cmantunes@gmail.com> wrote:
>
> > > running the code i simply get:
> > >
> > > ~$ ./timing
> > > Failed to create thread # 382
>
> i suspect this is due to the stack ulimit being too high. Try something
> like 'ulimit -s 128', which will make it 128K, instead of the default
> 8MB.
>

Ingo,

First of all, thank you for all the great work you've contributed to
the Linux community.

Now the question: do you have any ideas about what might make
SCHED_OTHER perform better than SCHED_FIFO when in the presence of a
great number of (mostly) sleeping threads?

Thanks!

Carlos

--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson

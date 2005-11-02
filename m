Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVKBQxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVKBQxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVKBQxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:53:53 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:42727 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965133AbVKBQxw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:53:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dzl5zlMiX0bnrAVVaT4JHQ5YYedyPIEnqjC4bkN0iqyWuiM5FfDDO3HmNvOA60HBipO+wa/hY3ui+GUjO1UPwCxCYQs3ZX2qQXFMiAPoxu8T6jjbI7x3FbMgjZBL/lt+1Gu6sgIfzI7XEy6x3T7W/ytQu9AH1o6+dvYcdh4Nj6o=
Message-ID: <cb2ad8b50511020853x12660109l944cc319085c7e93@mail.gmail.com>
Date: Wed, 2 Nov 2005 11:53:51 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.14-rt1
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1130948681.29788.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051030133316.GA11225@elte.hu>
	 <1130902342.29788.23.camel@localhost.localdomain>
	 <cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com>
	 <20051102102116.3b0c75d1@mango.fruits.de>
	 <cb2ad8b50511020635qb355f33w6f3638972556c242@mail.gmail.com>
	 <20051102144015.GA19845@elte.hu>
	 <cb2ad8b50511020645i23c164d4h7140c4c352159974@mail.gmail.com>
	 <1130945876.29788.28.camel@localhost.localdomain>
	 <cb2ad8b50511020807y4617c6a4pcd0ee27b635c9c34@mail.gmail.com>
	 <1130948681.29788.30.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So Ingo,  what did you fix?  :)  (since now it's also at -rt4)
>

Maybe this was the culprit?

On Wed, Nov 02, 2005 at 02:12:29PM +0100, Ingo Molnar wrote:
>
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
>
> > Hello!
> >
> > I guess I need to be more careful when creating experimental RCU
> > patches, as people have been copying my mistakes.  Here is a patch to
> > fix some of them in -rt.
>
> thanks, applied - will show up in -rt3. Should be done for -mm too,
> which now includes rcu-signal-handling.patch?



--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSFJHna>; Mon, 10 Jun 2002 03:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSFJHn3>; Mon, 10 Jun 2002 03:43:29 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:15041
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP
	id <S316751AbSFJHn3>; Mon, 10 Jun 2002 03:43:29 -0400
Message-ID: <20020610074329.24411.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Dag Nygren <dag@newtech.fi>,
        Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        linux-kernel@vger.kernel.org, dag@newtech.fi
Subject: Re: Devfs strangeness in 2.4.18 
In-Reply-To: Message from Richard Gooch <rgooch@ras.ucalgary.ca> 
   of "Fri, 07 Jun 2002 10:34:50 MDT." <200206071634.g57GYoi14530@vindaloo.ras.ucalgary.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jun 2002 10:43:29 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dag Nygren writes:
> > > Also check that you don't have bogus entries in your dev-state
> > > area. Mandrake had some configuration problems a few months back.
> > 
> > Yess!!!
> > That's what did it, removing the sg? and st? entries from /lib/dev-state
> > did the trick. There were some oldies ghosting there. Thanks a lot 
> > Richard, I didn't even know that there was a dev-state directory to
> > look for ;-).
> 
> I've added an item to the FAQ about this.

A very good idea.

> > Is there any comprehensive documentation on devfsd and devfs
> > anywhere on the net? Could be good to read a bit more about this.
> 
> Have you not looked at the FAQ?

Yes, but looking for sg and st stuff I didn't looh that carefully.
What I was missing at that time was a walkthrough of the 
devfs and devfsd default operations.

Anyway it work beatifully now.
Thanks again

Dag



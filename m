Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSBYVUi>; Mon, 25 Feb 2002 16:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSBYVU3>; Mon, 25 Feb 2002 16:20:29 -0500
Received: from adsl-217-220.38-151.net24.it ([151.38.220.217]:32184 "EHLO
	valeria.casa") by vger.kernel.org with ESMTP id <S288748AbSBYVUK>;
	Mon, 25 Feb 2002 16:20:10 -0500
Date: Mon, 25 Feb 2002 22:16:49 +0100 (CET)
From: marco <marco@tux.dynu.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: suparna@in.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel support of socket async I/O
In-Reply-To: <20020225142013.E11675@redhat.com>
Message-ID: <Pine.LNX.4.21.0202252215210.1159-100000@valeria.casa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where can I find the latest network aio stuff? Just to start having a look
at it ....

marco


On Mon, 25 Feb 2002, Benjamin LaHaise wrote:

> On Mon, Feb 25, 2002 at 05:05:41PM +0100, marco wrote:
> > Hello Benjamin and all of the guys on the lists,
> > I'm pretty much interested in socket async I/O for a project at work. I
> > read the document at 
> ...
> > I also searched linux-kernel archives for some status information, but
> > couldn't gain much info (other than a couple of discussion threads back in
> > late 1999).
> > What we need is a standard aio/thread-pool-in-sigwaitinfo architecture and
> > we wouldn't like to use select/poll.
> ...
> 
> Recent development activity was mostly geared at raw block device and 
> filesystem aio (as that's what the testers are using).  I did post patches 
> for network aio, but dropped them due to time constraints.  Now that the 
> most recent flurry of fixes to the aio core is complete (it's looking 
> very good now), I need to get the core bits updated for 2.5 and see how 
> much can be merged.  As for help, the network bits need polish and testing 
> to get to the near-release quality of the rest of the code.
> 
> 		-ben
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

---------------------------------------------------

      ~
     . .
     /V\     Computers are like air conditioners.
    // \\   They stop working when you open Windows.
   /(   )\
    ^`~'^


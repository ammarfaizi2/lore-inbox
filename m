Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSFGQey>; Fri, 7 Jun 2002 12:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317306AbSFGQex>; Fri, 7 Jun 2002 12:34:53 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:15747 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317209AbSFGQex>; Fri, 7 Jun 2002 12:34:53 -0400
Date: Fri, 7 Jun 2002 10:34:50 -0600
Message-Id: <200206071634.g57GYoi14530@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Dag Nygren <dag@newtech.fi>
Cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Devfs strangeness in 2.4.18 
In-Reply-To: <20020607074629.27617.qmail@dag.newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dag Nygren writes:
> > Also check that you don't have bogus entries in your dev-state
> > area. Mandrake had some configuration problems a few months back.
> 
> Yess!!!
> That's what did it, removing the sg? and st? entries from /lib/dev-state
> did the trick. There were some oldies ghosting there. Thanks a lot 
> Richard, I didn't even know that there was a dev-state directory to
> look for ;-).

I've added an item to the FAQ about this.

> Is there any comprehensive documentation on devfsd and devfs
> anywhere on the net? Could be good to read a bit more about this.

Have you not looked at the FAQ?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

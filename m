Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277191AbRJDRTc>; Thu, 4 Oct 2001 13:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277189AbRJDRTW>; Thu, 4 Oct 2001 13:19:22 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:65154 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277185AbRJDRTO>; Thu, 4 Oct 2001 13:19:14 -0400
Date: Thu, 4 Oct 2001 11:19:34 -0600
Message-Id: <200110041719.f94HJYQ07125@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Schwab <schwab@suse.de>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <jehetfcr73.fsf@sykes.suse.de>
In-Reply-To: <m1n137zbyo.fsf@frodo.biederman.org>
	<Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com>
	<200110041602.f94G20k06280@vindaloo.ras.ucalgary.ca>
	<jehetfcr73.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab writes:
> Richard Gooch <rgooch@ras.ucalgary.ca> writes:
> 
> |> Linus Torvalds writes:
> |> > 
> |> > On 4 Oct 2001, Eric W. Biederman wrote:
> |> > >
> |> > > First what user space really wants is the MAP_COPY.  Which is
> |> > > MAP_PRIVATE with the guarantee that they don't see anyone else's changes.
> |> > 
> |> > Which is a completely idiotic idea, and which is only just another
> |> > example of how absolutely and stunningly _stupid_ Hurd is.
> |> 
> |> Indeed. If you're updated a shared library, why not *create a new
> |> file* and then rename it?!? That lets running programmes work fine,
> |> and new programmes will get the new library. Also, the following
> |> construct makes a lot of sense:
> |> 	ld -shared -o libfred.so *.o || mv libfred.so /usr/local/lib
> 
> That || should be &&, otherwise you are doing exactly the opposite
> of what you want.

Yeah. Of course. Brain fart. Fingers faster than brain syndrome...

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

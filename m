Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbRGSRD1>; Thu, 19 Jul 2001 13:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265377AbRGSRDR>; Thu, 19 Jul 2001 13:03:17 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:29713 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S265326AbRGSRDG>; Thu, 19 Jul 2001 13:03:06 -0400
Date: Thu, 19 Jul 2001 10:59:34 -0600
Message-Id: <200107191659.f6JGxYh13394@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap usage of high memory (fwd)
In-Reply-To: <Pine.LNX.4.33.0107190940370.7162-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33L.0107191059460.13351-100000@imladris.rielhome.conectiva>
	<Pine.LNX.4.33.0107190940370.7162-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Linus Torvalds writes:
> Note that the unfair aging (apart from just being a natural
> requirement of higher allocation pressure) actually has some other
> advantages too: it ends up being aload balancing thing. Sure, it
> might throw out some things that get "unfairly" treated, but once we
> bring them in again we have a better chance of bringing them into a
> zone that _isn't_ under pressure.

What about moving data to zones with free pages? That would save I/O.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

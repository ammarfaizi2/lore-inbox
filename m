Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbRACP5i>; Wed, 3 Jan 2001 10:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131372AbRACP5S>; Wed, 3 Jan 2001 10:57:18 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:39410 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131138AbRACP5H>; Wed, 3 Jan 2001 10:57:07 -0500
Date: Wed, 3 Jan 2001 13:26:18 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "Dr. David Gilbert" <gilbertd@treblig.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com>
Message-ID: <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Dr. David Gilbert wrote:

>   I got wondering as to whether the various journaling file
> system activities were designed to survive the occasional
> unclean shutdown or were designed to allow the user to just pull
> the plug as a regular means of shutting down.

>   Thoughts?

1. a journaling filesystem is designed to be "consistent"
   (or rather, easily recoverable) all of the time
2. there's no difference between the "2 situations" you
   describe above

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRH0UEA>; Mon, 27 Aug 2001 16:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268217AbRH0UDv>; Mon, 27 Aug 2001 16:03:51 -0400
Received: from ns.cablesurf.de ([195.206.131.193]:39163 "EHLO ns.cablesurf.de")
	by vger.kernel.org with ESMTP id <S268071AbRH0UDe>;
	Mon, 27 Aug 2001 16:03:34 -0400
Message-Id: <200108272013.WAA20853@ns.cablesurf.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 22:03:07 +0200
X-Mailer: KMail [version 1.3]
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108271213370.5646-100000@imladris.rielhome.cone ctiva> <516649838.998944465@[169.254.198.40]>
In-Reply-To: <516649838.998944465@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Thinking about it a bit more, we also want to drop pages
> from fast streams faster, to an extent, than we drop
> them from slow streams (as well as dropping quite
> a few pages at once), as these 'cost' more to replace.

what leads you to this conclusion ?
A task that needs little time to process data it reads in is hurt much more 
by added latency due to a disk read.

	Regards
		Oliver

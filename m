Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281880AbRKWENH>; Thu, 22 Nov 2001 23:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281881AbRKWEM5>; Thu, 22 Nov 2001 23:12:57 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:29865 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281880AbRKWEMr>; Thu, 22 Nov 2001 23:12:47 -0500
Date: Thu, 22 Nov 2001 21:12:27 -0700
Message-Id: <200111230412.fAN4CRu06701@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Sigmund Augdal <Sigmund.Augdal@idi.ntnu.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Error using devfs
In-Reply-To: <Pine.GSO.4.31.0111181522460.13084-200000@vier.idi.ntnu.no>
In-Reply-To: <Pine.GSO.4.31.0111181522460.13084-200000@vier.idi.ntnu.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigmund Augdal writes:
> I tried using devfs with 2.4.14 and my computer crashed during boot,
> afterwards the the logs showed entries like the one attatched. Even
> if devfs is experimental code it should at least panic with an
> errormessage.

Devfs isn't the only code that can panic without a warning. If some
code gets passed a bogus pointer, there's not a lot you can do
(without putting in error checking on almost every line, and if we did
that, our performance would suck).

> I am able to recreate the problem, and I can giv more info if
> someone talls me what to say.

Please grab the latest devfs patch and apply it to kernel 2.4.15-pre9
or later. If the problem persists, please send a bug report directly.
Patch available at:

ftp://ftp.no.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-v198.gz

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

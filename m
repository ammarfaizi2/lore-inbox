Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRJKMKS>; Thu, 11 Oct 2001 08:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276135AbRJKMKI>; Thu, 11 Oct 2001 08:10:08 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:5371 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S276132AbRJKMJt> convert rfc822-to-8bit; Thu, 11 Oct 2001 08:09:49 -0400
Date: Thu, 11 Oct 2001 13:10:16 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: =?iso-8859-1?Q?Pekka_Pietik=E4inen?= <pp@netppl.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Tainted Modules Help Notices
In-Reply-To: <20011011124144.A20659@netppl.fi>
Message-ID: <Pine.SOL.4.33.0110111304430.18253-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Pekka Pietikäinen wrote:

> On Thu, Oct 11, 2001 at 09:35:34AM +0000, Henning P. Schmiedehausen wrote:
> > How about
> >
> > "BSD (included in kernel source)"
> >
> > to make clear that this is part of the distributed kernel _sources_.
> >
> > "included in kernel" could also be a 3rd party binary only driver
> > added by a Linux distribution vendor.
> Or even something like "BSD (unmodified source freely available)", which
> would cover 3rd party drivers as well.

"BSD (GPL compatible)"? Or a more generic "Other GPL compatible"?

For that matter, it's not GPL compatibility that matters here, it's source
availability for debugging purposes; AIUI, even an "old-style BSD" module
shouldn't taint the kernel.

Better still, rather than the licensing details, have the source URL.
Either MODULE_SOURCE_URL("http://example.com/drivers/linux/scsi.html") or
MODULE_BINARY_ONLY, with the latter tainting the kernel since the source
is not *freely* available?


James.
-- 
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKLAo>; Mon, 11 Dec 2000 06:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbQLKLAe>; Mon, 11 Dec 2000 06:00:34 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:5389 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S129314AbQLKLAW>;
	Mon, 11 Dec 2000 06:00:22 -0500
To: Steven Walter <srwalter@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre25, S3, AMD K6-2, and MTRR....
In-Reply-To: <Pine.LNX.4.21.0012092218280.877-100000@u>
	<14898.42117.34020.145433@critterling.garfield.home>
	<y7ru28cdtow.fsf@sytry.doc.ic.ac.uk>
	<20001210123438.A9659@hapablap.dyn.dhs.org>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 11 Dec 2000 10:29:53 +0000
In-Reply-To: Steven Walter's message of "Sun, 10 Dec 2000 12:34:38 -0600"
Message-ID: <y7rn1e38d3y.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Walter <srwalter@yahoo.com> writes:
> On Sun, Dec 10, 2000 at 06:20:31PM +0000, David Wragg wrote:
> > If I understood why the MTRR driver was doing something on the K6-2,
> > then model-specific differences might make some sense.  But currently,
> > I don't see why there would be any difference between "MTRR disabled"
> > and "MTRR enabled, but not used".
> 
> If I'm not mistaken, X /does/ touch the MTRR's, which would explain why
> it is X that crashes.

Only in XFree86-4.x (I never distributed my MTRR patches for
XFree86-3.x ;-).  Which is why the XFree86 version was one of the
things I wanted to confirm.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

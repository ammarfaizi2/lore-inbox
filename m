Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131155AbQLLOAR>; Tue, 12 Dec 2000 09:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130231AbQLLOAI>; Tue, 12 Dec 2000 09:00:08 -0500
Received: from 213-123-74-239.btconnect.com ([213.123.74.239]:13573 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131155AbQLLN7t>;
	Tue, 12 Dec 2000 08:59:49 -0500
Date: Tue, 12 Dec 2000 13:31:26 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
In-Reply-To: <200012121319.OAA10288@microsoft.com>
Message-ID: <Pine.LNX.4.21.0012121329120.1345-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 2000, Xavier Bestel wrote:

> > What's the best way to capture (manually or otherwise) a rather long
> > oops that scrolls off my console without having a second machine?
> > 
> > I'm gonna try to compile in a framebuffer and use a high resolution and
> > see if that'll hold it all when I get back later today.
> 
> shift+pageup ?

the problem with Shift-PgUP is that all the framebuffer drivers I tried
(matrox, ati, vesa) corrupt the screen when it is used. The only way to
use Shift-PgUp reliably I have ever seen was on vgacon. These bugs seemed
to be there for years so I didn't even bother reporting them - I just got
used to the idea "using fb? forget the Shift-PgUP then".

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

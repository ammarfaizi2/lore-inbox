Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288276AbSA0Ry1>; Sun, 27 Jan 2002 12:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288284AbSA0RyR>; Sun, 27 Jan 2002 12:54:17 -0500
Received: from pop.gmx.de ([213.165.64.20]:46941 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S288276AbSA0RyG>;
	Sun, 27 Jan 2002 12:54:06 -0500
Message-ID: <3C543E86.7F0FA37A@gmx.net>
Date: Sun, 27 Jan 2002 18:53:10 +0100
From: root <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: CRAP in 2.4.18-pre7
In-Reply-To: <20020126171545.GB11344@fefe.de> <3C52E671.605FA2F3@mandrakesoft.com> <3C540A90.5020904@evision-ventures.com> <3C542FE6.7C56D6BD@mandrakesoft.com> <3C5439C1.6000305@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

> Jeff Garzik wrote:
>
> >Martin Dalecki wrote:
> >
> >>I would like to notice that the changes in 2.4.18-pre7 to the
> >>tulip eth driver are apparently causing absymal performance drops
> >>on my version of this card. Apparently the performance is dropping
> >>>from the expected 10MB/s to about 10kB/s. The only special
> >>thing about the configuration in question is the fact that it's
> >>a direct connection between two hosts. Well, more precisely it's
> >>a cross-over link between my notebook and desktop.
> >>
> >
> >Are you seeing collisions?
> >
> NO not at all! The transfer is one with scp over a corssover direct link
> between two hosts.
> No hub between involved.

You don't need a hub to have collisions.

Duplex mismatch (i.e. one card in full-duplex, the other in half-duplex)
would just show 10-50 KByte/sec transfer rates typically.

The card's statistics about "collisions" and "late collisions" would
positively prove if this is the case.


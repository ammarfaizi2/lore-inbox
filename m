Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132633AbRC2AY1>; Wed, 28 Mar 2001 19:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132631AbRC2AYR>; Wed, 28 Mar 2001 19:24:17 -0500
Received: from [209.81.55.6] ([209.81.55.6]:26632 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S132633AbRC2AYD>;
	Wed, 28 Mar 2001 19:24:03 -0500
Date: Wed, 28 Mar 2001 16:53:05 -0500 (EST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
cc: Daniela Magri <daniela@cyclades.com>
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <3AC27DB3.C2E20FC5@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0103281650520.15795-100000@intra.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2001, Jeff Garzik wrote:

> Ivan Passos wrote:
> > Maybe it's a better idea to have just two ioctl's here (GET and SET), and
> > have "subioctl's" inside the structure passed to the HDLC layer (and
> > defined by the HDLC layer). This would allow changes in the HDLC layer
> > without having to change sockios.h (you'd still have to change HDLC's
> > code and definitions, but this would be more self-contained). Again, this
> > may be better, or maybe not. What do you think?
>
> That's essentially what's happening with ethtool
> (include/linux/ethtool.h in 2.4.3-pre8)

Then maybe it's really a better idea, after all. ;)

Krzysztof, please let us know what you think.

Regards,
Ivan


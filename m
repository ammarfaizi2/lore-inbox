Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132730AbRC2Mi3>; Thu, 29 Mar 2001 07:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132729AbRC2MiU>; Thu, 29 Mar 2001 07:38:20 -0500
Received: from zeus.kernel.org ([209.10.41.242]:28106 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132730AbRC2MiD>;
	Thu, 29 Mar 2001 07:38:03 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <Pine.LNX.4.30.0103281558140.15795-100000@intra.cyclades.com>
	<3AC27DB3.C2E20FC5@mandrakesoft.com>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 29 Mar 2001 13:29:32 +0200
In-Reply-To: Jeff Garzik's message of "Wed, 28 Mar 2001 19:11:31 -0500"
Message-ID: <m3u24c6cf7.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> > Maybe it's a better idea to have just two ioctl's here (GET and SET), and
> > have "subioctl's" inside the structure passed to the HDLC layer (and
> > defined by the HDLC layer). This would allow changes in the HDLC layer
> > without having to change sockios.h (you'd still have to change HDLC's
> > code and definitions, but this would be more self-contained). Again, this
> > may be better, or maybe not. What do you think?
> 
> That's essentially what's happening with ethtool
> (include/linux/ethtool.h in 2.4.3-pre8)

Right. While I don't think ethernet-only interface is our ultimate goal,
I'll look at it again to see if I can stole some idea there.
-- 
Krzysztof Halasa
Network Administrator

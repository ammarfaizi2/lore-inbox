Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUHWOcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUHWOcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUHWOcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:32:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12996 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264668AbUHWOcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:32:15 -0400
Date: Mon, 23 Aug 2004 10:11:37 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, jgarzik@pobox.com
Subject: Re: [PATCH 2.4] gcc-3.4 more fixes
Message-ID: <20040823131137.GA1779@logos.cnet>
References: <4129F41A.3070805@ttnet.net.tr> <20040823123430.GD4569@logos.cnet> <4129FB86.40508@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4129FB86.40508@ttnet.net.tr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 05:13:26PM +0300, O.Sezer wrote:
> Marcelo Tosatti wrote:
> >On Mon, Aug 23, 2004 at 04:41:46PM +0300, O.Sezer wrote:
> >
> >>>>Ozkan,
> >>>>
> >>>>This are just warning fixes right?
> >>>>
> >>>>I dont like this patches, that is, I'm not confident about them.
> >>>>
> >>>>Let the warnings be.
> >>>
> >>>For gcc-3.4 they're warnings. For gcc-3.5 they'll cause compiler
> >>>failures (that's what mikpe says on cset-1.1490, too)
> >>
> >>As a side note, almost all of them are in 2.6 anyway (can't
> >>honestly remember which aren't)
> >
> >
> >Have you nocited the deadly mistake you made I showed with the grep?
> >
> 
> Oopss :/  Than 2.6 has the same deadly thing. I'm too trusting I
> guess..  The correct thing should be to change "if (!(PRIV(dev) ="
> into "if (!(dev->phy_data =", right?

I think so yes. A network driver expert can confirm this for us.

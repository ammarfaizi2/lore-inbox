Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbTCZMgV>; Wed, 26 Mar 2003 07:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbTCZMgV>; Wed, 26 Mar 2003 07:36:21 -0500
Received: from Mail1.KONTENT.De ([81.88.34.36]:23470 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id <S261653AbTCZMgT> convert rfc822-to-8bit;
	Wed, 26 Mar 2003 07:36:19 -0500
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>, Greg KH <greg@kroah.com>
Subject: Re: Preferred way to load non-free firmware
Date: Wed, 26 Mar 2003 13:47:27 +0100
User-Agent: KMail/1.5
Cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0303252007420.6656-100000@marabou.research.att.com> <20030326041146.GD20858@kroah.com> <20030326104856.GA31375@axis.demon.co.uk>
In-Reply-To: <20030326104856.GA31375@axis.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261347.27137.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 26. März 2003 11:48 schrieb Nick Craig-Wood:
> On Tue, Mar 25, 2003 at 08:11:46PM -0800, Greg KH wrote:
> > > 7) Encode the firmware into a header file, add it to the driver and
> > > pretend that the copyright issue doesn't exist (like it's done in the
> > > Keyspan USB driver).
> >
> > Hey, that's the way I like doing this stuff :)
>
> If you do this the Debian kernel mainainers will mercilessly rip your
> non-free driver firmware from the standard Debian kernel.  At least
> that is what happened with the Keyspan :-(

That's their problem then. Or rather their users.
IMHO a maintainer's responsibility ends at kernel.org.
>From a technical point of view the firmware needs to be
in ram when you resume from sleep. If you don't care about
updating it, having it in the kernel image uses somewhat less
resources. So I'd say go for it.

	Regards
		Oliver



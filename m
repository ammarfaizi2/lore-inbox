Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264849AbTFTVel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbTFTVel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:34:41 -0400
Received: from lucidpixels.com ([66.45.37.187]:59557 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S264849AbTFTVee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:34:34 -0400
Date: Fri, 20 Jun 2003 17:48:35 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: Joe Briggs <jbriggs@briggsmedia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Maximum Linux IDE Device Support
In-Reply-To: <200306201709.16237.jbriggs@briggsmedia.com>
Message-ID: <Pine.LNX.4.56.0306201747020.16249@p500>
References: <Pine.LNX.4.56.0306201351190.16249@p500> <200306201709.16237.jbriggs@briggsmedia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very nice, but in the 2.4.21 driver (going to the help option), I see
that it only supports the 4 and 8 card versions, is the 12 port version
supported?

And I'm still trying to find out if anyone has used more than 4 Promise
Boards under Linux 2.4.x. :)

Thanks.

On Fri, 20 Jun 2003, Joe Briggs wrote:

> You might want to consider the 3ware controllers.  The have 2, 4, 8, and 12
> channel versions.  All but the 2 channel are 32-bit.  Their benefit is that
> they are scsci controllers (to the bus) that control ide drives.  They are
> MUCH FASTER and infinetely more reliable under VERY HEAVY loads. That is, if
> you have other pci cards such as frame grabbers that bus master and blast
> lots of data accross the bus, the ide controllers can loose interrupts and
> corrupt the file system on your drives.  The 3ware boards eliminate this
> painful problem and take only one irq.
>
> On Friday 20 June 2003 01:52 pm, war wrote:
> > How many Promise ATA/133 controllers are supported under 2.4.x on the same
> > box?
> >
> > How many can be used at the same time (PCI)?
> >
> > I read somewhere that 4 is supported, but are more than 4 possible? 5-6
> > possibly?
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> Joe Briggs
> Briggs Media Systems
> 105 Burnsen Ave.
> Manchester NH 03104 USA
> TEL/FAX 603 232 3115
> www.briggsmedia.com
>

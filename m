Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbRGKMXj>; Wed, 11 Jul 2001 08:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbRGKMX3>; Wed, 11 Jul 2001 08:23:29 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29572 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S267300AbRGKMXU>;
	Wed, 11 Jul 2001 08:23:20 -0400
Message-ID: <3B4C4533.26A5B28A@mandrakesoft.com>
Date: Wed, 11 Jul 2001 08:23:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>,
        Patrick Mochel <mochel@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        saw@saw.sw.com.sg
Subject: Re: 2.4.6.-ac2: Problems with eepro100
In-Reply-To: <Pine.LNX.4.33.0107111413380.19006-100000@chaos.tp1.ruhr-uni-bochum.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
> On Wed, 11 Jul 2001, Martin Knoblauch wrote:
> 
> > > Do a register dump of working and dead-after-PM-transition, including
> > > PCI config registers, and look for differences.  Also look for
> > > differences in your host and PCI-PCI bridge PCI config registers.
> >
> >  Instructions on how to do the dumps? Sorry, I have not been that deep
> > into these matters until now :-)
> 
> For the PCI things: Do a lspci -vvxxx at the various stages of working /
> not working and diff them. For the chip registers - well, I didn't look
> into this yet, but it'll be a bit harder, I suppose. (Maybe the maintainer
> has some hints?)

download eepro-diag.c from ftp://www.scyld.com/diag/

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |

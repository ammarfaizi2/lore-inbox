Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263540AbRFAOqF>; Fri, 1 Jun 2001 10:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263545AbRFAOpz>; Fri, 1 Jun 2001 10:45:55 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:34190 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S263540AbRFAOpl>;
	Fri, 1 Jun 2001 10:45:41 -0400
Date: Fri, 1 Jun 2001 10:45:29 -0400
From: Mark Frazer <mark@somanetworks.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
Message-ID: <20010601104529.D5248@somanetworks.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010601103749.C5248@somanetworks.com> <E155q3E-0000bH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E155q3E-0000bH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jun 01, 2001 at 03:37:19PM +0100
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> [01/06/01 10:39]:
> > I'd argue for rate limiting as the application only gets back new data,
> > never a cached value n times in a row.
> 
> Which is worse. I cat the proc file a few times and your HA app is unlucky. It
> now gets *NO* data for five minutes. If we cache the values it gets approximate
> data
> 

Is it not possible to have several readers waiting for the same data
and return it to all of them when the timer expires?


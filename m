Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268500AbRG3LWd>; Mon, 30 Jul 2001 07:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268506AbRG3LWX>; Mon, 30 Jul 2001 07:22:23 -0400
Received: from aravis.cur-archamps.fr ([195.202.0.99]:25093 "EHLO
	aravis.cur-archamps.fr") by vger.kernel.org with ESMTP
	id <S268503AbRG3LWO>; Mon, 30 Jul 2001 07:22:14 -0400
Date: Mon, 30 Jul 2001 13:22:21 +0200
From: Thierry Laronde <thierry@cri74.org>
To: Marcus Meissner <mm@ns.caldera.de>
Cc: Debian boot mailing list <debian-boot@lists.debian.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PCI] building PCI IDs/drivers DB from Linux kernel sources
Message-ID: <20010730132221.D25441@pc04.cri.cur-archamps.fr>
In-Reply-To: <20010730113319.A24939@pc04.cri.cur-archamps.fr> <200107301103.f6UB31e20045@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107301103.f6UB31e20045@ns.caldera.de>; from mm@ns.caldera.de on Mon, Jul 30, 2001 at 01:03:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 01:03:01PM +0200, Marcus Meissner wrote:
> In article <20010730113319.A24939@pc04.cri.cur-archamps.fr> you wrote:
> > Please note that in the following, these are remarks _not_ bad criticism.
> > Maybe what is found by the script could be of some interest to people
> > coordinating the source writing.
> 
> > GOAL
> > ----
> 
> > In order to allow a kind of light detection of hardware to be use during
> > installation, I wanted to build a database (for PCI: I start with the
> > easiest...) with the following format:
> 
> > CLASS_ID	VENDOR_ID	DEVICE_ID	driver_name
> 
> > I have decided to write a script (you will find all the stuff attached)
> > parsing the Linux kernel sources in order to do that.
> 
> Well, that was what I did 2 years ago for Caldera ;)
> 
> Howevery this is no longer needed.
> 
> Nearly all PCI kernel modules now export the ids they match for in the
> MODULE_DEVICE_TABLE, for PCI, ISAPNP and USB.

I might have missed something ;) The use of MODULE_DEVICE_TABLE seemed not
general. Thanks for the infos.
-- 
Thierry LARONDE, Centre de Ressources Informatiques, Archamps - France
http://www.cri74.org/

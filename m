Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbUJ1MxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbUJ1MxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUJ1MxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:53:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48402 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263002AbUJ1MxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 08:53:12 -0400
Date: Thu, 28 Oct 2004 13:53:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "O.Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org,
       davej@redhat.com, Pete Zaitcev <zaitcev@redhat.com>, jgarzik@pobox.com,
       tglx@linutronix.de, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: Linux 2.4.28-rc1
Message-ID: <20041028135303.G3327@flint.arm.linux.org.uk>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	"O.Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org,
	davej@redhat.com, Pete Zaitcev <zaitcev@redhat.com>,
	jgarzik@pobox.com, tglx@linutronix.de,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
References: <417E5904.9030107@ttnet.net.tr> <20041026203334.GB29688@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041026203334.GB29688@logos.cnet>; from marcelo.tosatti@cyclades.com on Tue, Oct 26, 2004 at 06:33:34PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 06:33:34PM -0200, Marcelo Tosatti wrote:
> > - David Vrabel: TI CardBus PCI interrupt routing fix
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=108446444125446&w=2
> 
> Looks OK to me who dont have a clue about PCMCIA (it only tries
> to handle failure case, pretty safe).
> 
> rmk, can you take a look at this patch please?

I think this should be rejected, but since I'm not in posession of 2.4
source code anymore, I don't really know.

We did a lot of work in 2.6 to fix these issues properly.  I don't think
a "simple" fix is acceptable.  However, changing "irqmux" to be u32 is
obviously correct whatever.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

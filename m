Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWHQNJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWHQNJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWHQNJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:09:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:46400 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932471AbWHQNJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:09:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qunOdmizHBkfPyvC1h/BRK0zV5ucIp3ijA98bAaLeVwzLtJ9alvRipQspBJqhZ3bW5loXSlv+ibJ4pIR/LiLqHEfKCGXWG1VYHQ8xGEiSo8PuVQM2iM+rfBnmeFwXRHJk9aTxBXWFTJdvXB5dowN2RN/d9t9m+LT69riWBBcLbM=
Message-ID: <6bffcb0e0608170609g3926cad7wd3b4737d869ed794@mail.gmail.com>
Date: Thu, 17 Aug 2006 15:09:22 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [RFC][PATCH 0/75] pci_module_init to pci_register_driver conversion
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <44E46280.2020109@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060817042634.0.CrzcY28443.28439.michal@ltg01-fedora.pl>
	 <20060817055814.GA14950@kroah.com> <44E46280.2020109@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Jeff Garzik <jeff@garzik.org> wrote:
> Greg KH wrote:
> > On Thu, Aug 17, 2006 at 04:26:35AM +0000, Michal Piotrowski wrote:
> >> Hi,
> >>
> >> pci_module_init is obsolete.
> >>
> >> This patch series converts pci_module_init to pci_register_driver.
> >>
> >>
> >> Can I remove this?
> >>
> >> include/linux/pci.h:385
> >> /*
> >>  * pci_module_init is obsolete, this stays here till we fix up all usages of it
> >>  * in the tree.
> >>  */
> >> #define pci_module_init pci_register_driver
> >
> > As repeated numerous times, it's up to the network developers if they
> > will take this or not.
> >
> > I'll hold off on taking this series, please push it through the driver
> > subsystem maintainers.
>
> It's already in subsystem trees, in fact.

Did you mean http://www.kernel.org/git/?p=linux/kernel/git/davem/net-2.6.19.git;a=shortlog
?

The patches are against 2.6.18-rc4-mm1. Unfortunately patches weren't
delivered to netdev (my fault). I'll add To:<actual maintainer> and
resend.

>
> But it is most definitely not 2.6.18-rc material :)

I agree.

>
>         Jeff
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

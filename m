Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVJEEKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVJEEKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 00:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVJEEKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 00:10:55 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:48198 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965071AbVJEEKy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 00:10:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VLd8oR5ODuZjMGmN5gJvpzUS5vbbuENrV6p935Ll94FcFQrT3HAC4p1JGo0sojglzmK6H18VA7sbwQ3l9IIuXzmeSB9h5WDq9Sb3PjnhqtIBaP2VB9+eR+nws2nLqp3MTrxIdTtTNiCxBWNcGNRtR+nPru18gym2zyQ/nXxHm6k=
Message-ID: <b115cb5f0510042110j6ff08f9cvd0a3480f175a16ff@mail.gmail.com>
Date: Wed, 5 Oct 2005 13:10:53 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
To: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [Pcihpd-discuss] Re: ACPI problem with PCI Express Native Hot-plug driver
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       Linux-newbie@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       greg@kroah.com, dkumar@noida.hcltech.com, sanjayku@noida.hcltech.com
In-Reply-To: <b115cb5f0510022207k41df0380nfb8b4ee73149f7ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b115cb5f0509020057741365dc@mail.gmail.com>
	 <b115cb5f050902005877607db1@mail.gmail.com>
	 <1125683188.13185.5.camel@whizzy>
	 <b115cb5f05090418583abfc73@mail.gmail.com>
	 <b115cb5f0509292257j395d60f8j53d1afa967caa263@mail.gmail.com>
	 <20050930132440.C28328@unix-os.sc.intel.com>
	 <b115cb5f0510022207k41df0380nfb8b4ee73149f7ea@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 10/1/05, Rajesh Shah <rajesh.shah@intel.com> wrote:
> > On Fri, Sep 30, 2005 at 02:57:07PM +0900, Rajat Jain wrote:
> > >
> > > pciehp: pfar:cannot locate acpi bridge of PCI 0xb.
> > > ......
> > > pciehp: pfar:cannot locate acpi bridge of PCI 0xe.
> >
> > This is saying that the driver's probe function was called for
> > these pciehp capable bridges, but it didn't find them in the
> > ACPI namespace.
> >

Hi Rajesh,

Thanks a lot, for ending my doubts. I am working on a hardware that is
still under development. So the chances of missing certain things in
hardware / BIOS are high.  So the solution for this is to ask my
Hardware vendor to provide the information for these bridges into the
ACPI namespace (AML / DSDT?)?

Thanks a ton,

Rajat

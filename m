Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUJOAaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUJOAaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUJOAaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 20:30:22 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:34741 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S267285AbUJOA24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 20:28:56 -0400
Subject: Re: Fw: signed kernel modules?
From: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       rusty@ozlabs.au.ibm.com, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <14000.1097749066@redhat.com>
References: <1097707239.14303.22.camel@localhost.localdomain>
	 <1096544201.8043.816.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <1092369784.25194.225.camel@bach>
	 <20040812092029.GA30255@devserv.devel.redhat.com>
	 <20040811211719.GD21894@kroah.com>
	 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
	 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
	 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
	 <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <1097626296.4013.34.camel@localhost.localdomain>
	 <1097664137.4440.5.camel@localhost.! localdomain>
	 <14000.1097749066@redhat.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1097800090.22673.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 10:28:10 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 20:17, David Howells wrote:
> > I'd appreciate your opinion on the issue at hand.  Is it worth 600 lines
> > of ELF verification and canonicalization code so we can strip modules
> > without altering the signature?
> 
> You have to some of the ELF verification anyway, otherwise your suggested way
> is just as pointless. You had included somde code in your example, but what
> that did wasn't sufficient either - it can trivially be broken.

The current approach is working just fine.  I'm not the one trying to
prevent root from inserting malicious modules.  You are, so you need to
do the checks.

Rusty.



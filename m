Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUJMAUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUJMAUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUJMAUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:20:50 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:49386 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S267921AbUJMAUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:20:49 -0400
Subject: Re: Fw: signed kernel modules?
From: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Howells <dhowells@redhat.com>, rusty@ozlabs.au.ibm.com.kroah.org,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041012190826.GB31353@kroah.com>
References: <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <20041012190826.GB31353@kroah.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1097626835.4013.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 10:20:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 05:08, Greg KH wrote:
> On Tue, Oct 12, 2004 at 09:35:59AM +0100, David Woodhouse wrote:
> > 
> > We know _precisely_ what the kernel looks at -- we wrote its linker. It
> > really isn't that hard.
> 
> I agree.  We have to be able to detect improper header information for
> unsigned modules today, nothing new there.

No, we *don't*.  We check that it's the right arch, and ELF, and not
truncated.  Then we trust the contents.

I realize that ignorance is bliss, but if you want to debate this, I
recommend reading some code...

Rusty.



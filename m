Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUJLTLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUJLTLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUJLTJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:09:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:37029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267576AbUJLTJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:09:08 -0400
Date: Tue, 12 Oct 2004 12:08:26 -0700
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Howells <dhowells@redhat.com>, rusty@ozlabs.au.ibm.com.kroah.org,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041012190826.GB31353@kroah.com>
References: <30797.1092308768@redhat.com> <20040812111853.GB25950@devserv.devel.redhat.com> <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com> <27175.1095936746@redhat.com> <30591.1096451074@redhat.com> <10345.1097507482@redhat.com> <1097507755.318.332.camel@hades.cambridge.redhat.com> <1097534090.16153.7.camel@localhost.localdomain> <1097570159.5788.1089.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097570159.5788.1089.camel@baythorne.infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 09:35:59AM +0100, David Woodhouse wrote:
> 
> We know _precisely_ what the kernel looks at -- we wrote its linker. It
> really isn't that hard.

I agree.  We have to be able to detect improper header information for
unsigned modules today, nothing new there.  So by only signing the
information that the kernel looks at, we should be fine.

Or am I missing some big flaw in the above argument?

thanks,

greg k-h

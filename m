Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266106AbUA1XwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUA1XwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:52:18 -0500
Received: from mail.kroah.org ([65.200.24.183]:455 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266106AbUA1XwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:52:15 -0500
Date: Wed, 28 Jan 2004 15:51:12 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       francis.wiran@hp.com
Subject: Re: [PATCH] cpqarray update
Message-ID: <20040128235112.GC10906@kroah.com>
References: <200401262002.i0QK2iAH031857@hera.kernel.org> <40157552.3040405@pobox.com> <15D09760-51A9-11D8-AF96-000A95A0560C@us.ibm.com> <40184845.3030008@pobox.com> <40184960.7030207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40184960.7030207@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 06:44:32PM -0500, Jeff Garzik wrote:
> Jeff Garzik wrote:
> >Actually I disagree with GregKH on this.
> >
> >The register/unregister functions need to be returning error codes, 
> >_not_ the count of interfaces registered.  It is trivial to count the 
> >registered interfaces in the driver itself, but IMO far more important 
> >to propagate fatal errors back to the original caller.
> 
> Nevermind, this got fixed.  I'm still worried about the '1' return 
> value, though, for zero controllers found.

Yeah, I don't really like it either, but figured it was a 2.7 task to
clean it up properly.

thanks,

greg k-h

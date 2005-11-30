Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbVK3Qpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbVK3Qpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbVK3Qpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:45:36 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:12348 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751447AbVK3Qpf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:45:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eF9IxemeWaBIXiU2FPW6TsVeFv2xPkZHZZQOspBOi77R/PCpVNKWWYTBQXqtEceIWgvi3ELHeKra4Ce92fEggyi1EHTZQ7+xKXooV4a0CvIT+DG8/0PQkXif83tmsh3RQZTlaULL5X9FzKOw8EsrTQUW/eGFMqQuWJXkwBFl9F4=
Message-ID: <cda58cb80511300845j18c81ce6p@mail.gmail.com>
Date: Wed, 30 Nov 2005 17:45:33 +0100
From: Franck <vagabon.xyz@gmail.com>
To: Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
In-Reply-To: <20051130162327.GC1053@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb80511300821y72f3354av@mail.gmail.com>
	 <20051130162327.GC1053@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/30, Russell King <rmk+lkml@arm.linux.org.uk>:
> On Wed, Nov 30, 2005 at 05:21:35PM +0100, Franck wrote:
> > Hi,
> >
> > What about this patch which removes ARM dependency for dm9000 ethernet
> > controller driver ?
> >
> Maybe that should be (ARM || MIPS) && NET_ETHERNET ?
>

Well, if this dependency means "it has only be tested on ARM and
MIPS", then you're probably right. But if it means "this controller
must be run with an ARM or MIPS cpu" then I don't see why setting such
restriction. What do you think ?

thanks
--
               Franck

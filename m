Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVHBV76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVHBV76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVHBV76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:59:58 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:18274 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261807AbVHBV66 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:58:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=flP3AKZbL8SX0Y6O14Rg7gBEpc45UR9C3MuRShzwrG7G/6p+cE7FzFhMvloiXVph0RDCEPazcqvC1UR3iUtlN2yIuOcIBdjQxRhDVHGfIxxz3djpiLnWgywlOPIKweB5TG4Gh4Az3kx/YDUOLe/WYfGswCY+Zz4lexhz2vPCAUU=
Message-ID: <2ac89c700508021458206f2b8@mail.gmail.com>
Date: Wed, 3 Aug 2005 01:58:58 +0400
From: Dmitrij Bogush <dmitrij.bogush@gmail.com>
Reply-To: Dmitrij Bogush <dmitrij.bogush@gmail.com>
To: dtor_core@ameritech.net, dmitry.torokhov@gmail.com
Subject: Re: Touchpad errors
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <d120d50005080213296fac871e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EF633B.6080209@blueyonder.co.uk>
	 <d120d500050802072256a4d7ee@mail.gmail.com>
	 <2ac89c700508021314f42da6a@mail.gmail.com>
	 <d120d50005080213296fac871e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Acer laptops are notorious for buggy SMM implementations that disable
>interrupts for many timer ticks.  Does it work any better with HZ=100?

Maybe, but I do not see any difference between 100 and 1000 hz on 2.6.13-rc5. 
With 2.6.13(from rc4) I do not get "crazy jumps" like in 2.6.12 or
later, only freezes for 1 second.

> You may try to talk to ACPI people; also I recommend setting battery
> polling interval to something sane, like 1 minute, and make sure your
> tool does not touch  "info" file - that should help a bit.

Where can I find "ACPI people" ?

Thanks.

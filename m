Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSGIPxz>; Tue, 9 Jul 2002 11:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315513AbSGIPxy>; Tue, 9 Jul 2002 11:53:54 -0400
Received: from adsl-216-62-200-178.dsl.austtx.swbell.net ([216.62.200.178]:26523
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S315491AbSGIPxx>; Tue, 9 Jul 2002 11:53:53 -0400
Subject: Re: DELL array controller access.
From: Austin Gonyou <austin@digitalroadkill.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt_Domsch@Dell.com, dtroth@bellsouth.net, linux-kernel@vger.kernel.org
In-Reply-To: <E17RrxQ-0004XB-00@the-village.bc.nu>
References: <E17RrxQ-0004XB-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 09 Jul 2002 10:55:08 -0500
Message-Id: <1026230108.6979.2.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this is the case on these particular controllers. They are in
fact 147x controllers, with a 154x emulation mode. I used to support
lots of legacy equipment at Dell, and I believe that's the case, but if
Matt wants to chime in to confirm that or not, would be helpful. There's
lots of info on this as I believe there are still plenty of customers
actually still using 4100's and the like.

On Tue, 2002-07-09 at 05:10, Alan Cox wrote:
> > I know at a minimum...those cards can be put into a 154x mode, so it
> > will work. I remember that NetWare needed this feature.
> 
> If they are AHA147x based then the 154x mode has emulation errors and Linux
> specifically avoids using 154x drivers on them.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>

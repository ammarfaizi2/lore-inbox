Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317432AbSF1N7v>; Fri, 28 Jun 2002 09:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317437AbSF1N7u>; Fri, 28 Jun 2002 09:59:50 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:52951 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S317432AbSF1N7u>;
	Fri, 28 Jun 2002 09:59:50 -0400
Message-ID: <02f501c21eac$3a701f70$f6de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "Austin Gonyou" <austin@digitalroadkill.net>,
       "Chaoyang Deng" <cdeng@io.iol.unh.edu>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.43.0206271514230.9712-100000@io.iol.unh.edu> <1025243932.2956.3.camel@UberGeek>
Subject: Re: kernel BUG
Date: Fri, 28 Jun 2002 10:00:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI...6.0.27 is only for QLA2200 and QLA23XX.  I'm using 4.0.27beta for the QLA2100

It's hard to find on their website though (took a quick look just now and couldn't find it again).

----- Original Message ----- 
From: "Austin Gonyou" <austin@digitalroadkill.net>
To: "Chaoyang Deng" <cdeng@io.iol.unh.edu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, June 28, 2002 1:58 AM
Subject: Re: kernel BUG


> My recommendation for this is to *not* use the in-kernel qla2xxx driver.
> Not that it's necessarily bad mind you, but much new hardware doesn't
> seem to like it. I've locked up a box several times using it. Instead, I
> recommend that you go to qlogic's site and get 6.0.27 and try it. It's
> much faster than the previous drivers, and has been very stable and
> compile's with no warnings ever, at least in my scenario. 
> 
> I recently had an issue with a QL2xxx driver, some storage, and LUNs. My
> issue turned out to be a blacklist issue, but, I got a lot of info from
> the Qlogic folks as well, regarding which driver should be used today.
> 
> Hope this helps. 
> 
> On Thu, 2002-06-27 at 14:23, Chaoyang Deng wrote:
> > Hi,
> > 
> > I am working on an iSCSI target driver with a Fibre Channel disk. After I
> > updated my OS to linux7.3 with kernel 2.4.18-3, I got problem: my driver
> > will crash my box. I am not sure if it is a bug in my code or in the
> > Qlogic Fibre Channel driver or in the kernel. Could anyone give me a hint?
> 
> -- 
> Austin Gonyou <austin@digitalroadkill.net>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


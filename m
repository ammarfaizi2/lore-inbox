Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSLNRZE>; Sat, 14 Dec 2002 12:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbSLNRZE>; Sat, 14 Dec 2002 12:25:04 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:13208 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S263039AbSLNRZD>; Sat, 14 Dec 2002 12:25:03 -0500
Message-ID: <336830.1039886899684.JavaMail.nobody@web11.us.oracle.com>
Date: Sat, 14 Dec 2002 09:28:19 -0800 (GMT-08:00)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: zwane@holomorphy.com, valdis.kletnieks@vt.edu
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions) 
Cc: davej@codemonkey.org.uk, pekon@informatics.muni.cz,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 13 Dec 2002 Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 13 Dec 2002 17:36:56 GMT, Dave Jones said:
> >
> > > It's my understanding that pci_enable_device() *must* be called
> > > before we fiddle with dev->resource, dev->irq and the like.
> >
> > OK.. it looks like the problem only hits if it's a PCMCIA card *with an
> > onboard ROM*.
> Hmm i just saw this thread, which card is the non working one?;

It's a RBEM56G-100.

Sorry it took me a while to reply - Valdis' patch does fix the problem for
 me, too. Awaiting for a final form of the fix in the upcoming series :)


Thanks,

--alessandro

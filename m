Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275089AbTHQI7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 04:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275094AbTHQI7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 04:59:52 -0400
Received: from codepoet.org ([166.70.99.138]:29328 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275089AbTHQI7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 04:59:51 -0400
Date: Sun, 17 Aug 2003 02:59:49 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 1/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817085949.GA18756@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030817061238.GB17621@codepoet.org> <1061109862.21502.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061109862.21502.0.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 17, 2003 at 09:44:23AM +0100, Alan Cox wrote:
> On Sul, 2003-08-17 at 07:12, Erik Andersen wrote:
> > This patch eliminates HDIO_GETGEO_BIG and HDIO_GETGEO_BIG_RAW,
> > where are entirely unused and unnecessary.  They were also
> > removed from 2.6.x,
> 
> Rejected by 2.4 IDE maintainer. Removing API's (even dumb ones) during
> a stable release is not good practice. 

No worries.  The other patches do not depend on this one
and I suspected this one might get struck down.  I just 
carried it along to try and keep the 2.4 and 2.6 drivers 
consistant,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWJWDbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWJWDbT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWJWDbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:31:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32708 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751372AbWJWDbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:31:18 -0400
Subject: Re: 2.6.19-rc2-mm2
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jiri Kosina <jikos@jikos.cz>, Gabriel C <nix.or.die@googlemail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061020154325.78c38ead.akpm@osdl.org>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	 <4538BA2E.9040808@googlemail.com>
	 <Pine.LNX.4.64.0610201403090.29022@twin.jikos.cz>
	 <20061020154325.78c38ead.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 23 Oct 2006 00:29:54 -0300
Message-Id: <1161574194.31784.23.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sex, 2006-10-20 às 15:43 -0700, Andrew Morton escreveu:
> On Fri, 20 Oct 2006 14:04:09 +0200 (CEST)
> Jiri Kosina <jikos@jikos.cz> wrote:
> 
> > On Fri, 20 Oct 2006, Gabriel C wrote:
> > 
> > > I got this on ' make silentoldconfig '
> > > drivers/media/dvb/dvb-usb/Kconfig:72:warning: 'select' used by config
> > > symbol 'DVB_USB_DIB0700' refer to undefined symbol 'DVB_DIB7000M'
> > 
> > This is not a new warning, and should already be fixed for some two weeks 
> > or so in the v4l-dvb tree.
> 
> The -mm tree includes the dvb/v4l tree.  We've all been patiently waiting
> for that warning to go away for a few weeks now.
I've corrected it at the patches I sent to Linus. It seemed that I
forgot to apply a similar patch to -devel branch.

I've sent the proper fix to my -devel branch this weekend. 

It should have solved this issue by adding the proper DIB7000M code.
Those patches will probably be included into kernel 2.6.20.

Cheers, 
Mauro.


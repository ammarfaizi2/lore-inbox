Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263076AbTC1RsL>; Fri, 28 Mar 2003 12:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263077AbTC1RsL>; Fri, 28 Mar 2003 12:48:11 -0500
Received: from havoc.daloft.com ([64.213.145.173]:30372 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S263076AbTC1RsK>;
	Fri, 28 Mar 2003 12:48:10 -0500
Date: Fri, 28 Mar 2003 12:59:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Chris Bacott <cbacot@runbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100: wait_for_cmd_done timeout
Message-ID: <20030328175921.GB15852@gtf.org>
References: <200303281142.00430.cbacot@runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303281142.00430.cbacot@runbox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 11:42:00AM +0000, Chris Bacott wrote:
> > Thanks for the suggestion...
> > I got another one, telling me to have a look at the e100 driver,
> > and this raises a question I have for quite a long time : why does
> > the Kernel have two different supports for the same hardware ?
> > Is this a migration plan, a long run "please switch from eepro100
> > to e100" ?
> > Is there a better working one ?
> >
> Becuase, IIRC, eepro100 is the original EtherExpress100 Nic driver written by 
> Becker. the e100 Driver is written initially by Intel, and is a obviously 
> newer. Question is, would you want to use a driver written by the 
> manufacturer of the chip itself, or use a driver that has been in use for 
> MANY years, and has been proven solid.

This statement is utterly ridiculous, considering that the poster is
having problems with the eepro100 driver.  It is obviously, provably
_NOT_ solid.

In Red Hat's experience, some people find eepro100 very stable for
them, some people find e100 very stable for them.  There is no driver
which is 100% stable for all people at all times.

	Jeff




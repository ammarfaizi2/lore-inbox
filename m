Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWDFTcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWDFTcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 15:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWDFTb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 15:31:59 -0400
Received: from www.osadl.org ([213.239.205.134]:1212 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932159AbWDFTb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 15:31:59 -0400
Subject: Re: [PATCH 1/5] generic clocksource updates
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604062048130.17704@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
	 <1144317972.5344.681.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0604062048130.17704@scrub.home>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 21:32:24 +0200
Message-Id: <1144351944.5925.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-06 at 21:00 +0200, Roman Zippel wrote:
> > > -	int is_continuous;
> > 
> > This field was introduced to have a clear property description. The
> > rating field might be used for this, but from a given rating on a
> > particular CPU architecture it might be hard to deduce whether this
> > clock source is good enough so we can switch to high resolution timer
> > mode.
> 
> Currently this field isn't needed and as soon we have a need for it, we 
> can add proper capability information.

Is there a reason, why requirements which are known from existing
experience must be discarded to be reintroduced later ?

	tglx



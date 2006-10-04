Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWJDTaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWJDTaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWJDTaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:30:14 -0400
Received: from www.osadl.org ([213.239.205.134]:19431 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750892AbWJDTaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:30:12 -0400
Subject: Re: Industrial device driver uio/uio_*
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <20061004121835.bb155afe.akpm@osdl.org>
References: <1157995334.23085.188.camel@localhost.localdomain>
	 <1159988394.25772.97.camel@localhost.localdomain>
	 <20061004121835.bb155afe.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 21:32:25 +0200
Message-Id: <1159990345.1386.277.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 12:18 -0700, Andrew Morton wrote:
> On Wed, 04 Oct 2006 19:59:54 +0100
> > I would just NAK it but want to be sure the guys saw the list of
> > problems
> > 
> 
> cc's added.
> 
> Thomas has been a bit tied up with timers and interrupts of late.

Yup. fork(tglx) still returns -ETOOMANYINSTANCES.

I have no objections, if you pull it from -mm for now. The list of flaws
is accepted and we'll work on this in foreseeable time, _IF_ there is
some basic consensus about the idea itself not being fundamentaly wrong.

	tglx



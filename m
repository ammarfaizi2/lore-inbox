Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751871AbWIGVxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbWIGVxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 17:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWIGVxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 17:53:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751851AbWIGVxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 17:53:38 -0400
Date: Thu, 7 Sep 2006 14:50:36 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org
Subject: Re: [patch 37/37] sky2: version 1.6.1
Message-ID: <20060907145036.1f2a7bc4@localhost.localdomain>
In-Reply-To: <20060907210346.GF29890@elf.ucw.cz>
References: <20060906224631.999046890@quad.kroah.org>
	<20060906225812.GL15922@kroah.com>
	<20060907192528.GG8793@ucw.cz>
	<20060907203426.GB556@suse.de>
	<20060907210346.GF29890@elf.ucw.cz>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 23:03:46 +0200
Pavel Machek <pavel@suse.cz> wrote:

> Hi!
> 
> > > > -stable review patch.  If anyone has any objections, please let us know.
> > > > 
> > > > ------------------
> > > > From: Stephen Hemminger <shemminger@osdl.org>
> > > > 
> > > > Since this code incorporates some of the fixes from 2.6.18, change
> > > > the version number.
> > > > 
> > > > Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > > 
> > > Not sure, one of 'stable' criteria is 'fixes bad bug'. What bug does
> > > this fix?
> > 
> > The previous 5 patches changed this driver, so changing the version
> > number of it is acceptable to me.
> 
> Well... I agree that version change is understandable, but it will be
> also surprising for the users, and stable rules were quite strict with
> "must fix obvious bug"...
> 

I get lots of bug reports which are from distro and other kernels
that cherrypick code from stable. How am I supposed to know if it
is a new or old problem?

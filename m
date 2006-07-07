Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWGGTyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWGGTyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWGGTyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:54:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932298AbWGGTyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:54:46 -0400
Date: Fri, 7 Jul 2006 12:54:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: uwe.bugla@gmx.de, zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: boot errors in kernels 2.6.17-mm6 plus 2.6.18-rc1
Message-Id: <20060707125431.df4388ec.akpm@osdl.org>
In-Reply-To: <1152298515.5330.12.camel@localhost.localdomain>
References: <20060707124552.9650@gmx.net>
	<1152298515.5330.12.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 11:55:15 -0700
john stultz <johnstul@us.ibm.com> wrote:

> Andrew, its likely after we get this problem resolved we'll need another
> detect-and-warn patch for this lost-ticks case so we don't just
> wall-paper over bad pic/apic setups w/ robust timekeeping. Does that
> sound reasonable?

Sure.  Feel free to add any debug mesages which you think make your work
more effective.  We can remove any excessively noisy/scary ones around the
-rc5 time if needed.

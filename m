Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVD2I0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVD2I0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 04:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVD2I0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 04:26:17 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:59075 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S262461AbVD2I0H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 04:26:07 -0400
Date: Fri, 29 Apr 2005 10:25:23 +0200
To: coywolf@lovecn.org
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050429082522.GD18972@puettmann.net>
References: <20050427140342.GG10685@puettmann.net> <20050427152704.632a9317.rddunlap@osdl.org> <20050428090539.GA18972@puettmann.net> <20050428084313.1e69f59d.rddunlap@osdl.org> <2cd57c90050428093851785879@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2cd57c90050428093851785879@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1DRQoN-0000e2-00*FCcVfBjbEnk* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 12:38:24AM +0800, Coywolf Qi Hunt wrote:
> > Hm, no "console=tty...." at all.  That didn't help (me) much.
> Could that boot loader pxe append console=tty implicitly?

I found nothing about that pxe does this.
 
 
> It seems possible to luckily skip the garbage. Comment out the two
> lines and see if it works.
> 
> /*     if (late_time_init)
>              late_time_init(); */

In which file ?

                Ruben


-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net

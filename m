Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVGaSVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVGaSVj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVGaSVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:21:39 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:43793 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261848AbVGaSVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:21:38 -0400
Date: Sun, 31 Jul 2005 20:21:31 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050731182131.GA5236@roarinelk.homelinux.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> <42EC9410.8080107@roarinelk.homelinux.net> <20050731021628.42e3ab98.akpm@osdl.org> <42ECC822.7060802@roarinelk.homelinux.net> <20050731103528.4cb7f197.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731103528.4cb7f197.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 10:35:28AM -0700, Andrew Morton wrote:
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> >
> > Andrew Morton wrote:
> > > Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> > > 
> > >>something broke the sonypi driver a bit after -mm2:
> > >> I can no longer set bluetooth-power for instance, and it logs these
> > >> messages:
> > >>
> > >> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 605)
> > >> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 607)
> > >> sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 594)
> > >>
> > >> setting/getting brightness, getting battery/ac status still work.
> > >>
> > > 
> > > 
> > > Can you do a `patch -p1 -R' of the below, see if it fixes it?  It probably
> > > won't.
> > > 
> > > Also please test 2.6.13-rc4-mm1 which is missing the acpi tree...
> > > 
> > > Thanks.
> > 
> > 
> > Found the cause:
> 
> Wonderful, thanks.   So does that mean that 2.6.13-rc4 doesn't work?

Yes, sonypi is busted in -rc4 also.

-- 
 Manuel Lauss

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbUJYJPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUJYJPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUJYJPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:15:43 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:9300 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261726AbUJYJPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:15:32 -0400
Subject: Re: Buggy DSDTs policy ?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: "Yu, Luming" <luming.yu@intel.com>, Onur Kucuk <onur@delipenguen.net>,
       Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20041025090131.GA3404@ee.oulu.fi>
References: <3ACA40606221794F80A5670F0AF15F84041ABFE0@pdsmsx403>
	 <20041025090131.GA3404@ee.oulu.fi>
Content-Type: text/plain; charset=utf-8
Message-Id: <1098695638.11449.11.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 25 Oct 2004 11:13:58 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 25/10/2004 à 11:01, Pekka Pietikainen a écrit :
> On Mon, Oct 25, 2004 at 02:21:09PM +0800, Yu, Luming wrote:
> > >> Yes, sure. But real non-technical people won't replace their DSDT
> > >> either.
> > >Their distro could do it for them :-) A simple approach would be to
> > >store md5sums of known-bad dsdt's and xdeltas to fixed ones, and the 
> > >fixed one gets placed in /etc where mkinitrd automagically picks it up
> > >whenever a new kernel is installed.
> > 
> > I don't think distro can do that, because they are not the owner of
> > DSDT.
> That's what I said xdelta, so the only "new" code is patches against
> the broken vendor code in /proc/acpi/dsdt. But it's messy even
> that way, I know.

Hackish at best. Having an AML interpreter able to follow MS's quirks
seems a preferred solution (2.6.9's ACPI is said to be better at that, I
haven't tested it yet).

	Xav


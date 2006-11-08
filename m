Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161177AbWKHQyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWKHQyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWKHQyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:54:13 -0500
Received: from mta3.srv.hcvlny.cv.net ([167.206.4.198]:36054 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1161177AbWKHQyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:54:12 -0500
Date: Wed, 08 Nov 2006 11:54:08 -0500
From: David Bristow <djbristow@optonline.net>
Subject: Re: [PATCH 12/14] KVM: x86 emulator
In-reply-to: <200611071412.07196.mail@earthworm.de>
To: "Hesse, Christian" <mail@earthworm.de>
Cc: Avi Kivity <avi@qumranet.com>, Pavel Machek <pavel@ucw.cz>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Message-id: <1163004849.2652.1.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <454E4941.7000108@qumranet.com> <20061107124912.GA23118@elf.ucw.cz>
 <4550823E.2070108@qumranet.com> <200611071412.07196.mail@earthworm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 14:12 +0100, Hesse, Christian wrote:
> On Tuesday 07 November 2006 13:55, Avi Kivity wrote:
> > Pavel Machek wrote:
> > >> Index: linux-2.6/drivers/kvm/x86_emulate.c
> > >> ===================================================================
> > >> --- /dev/null
> > >> +++ linux-2.6/drivers/kvm/x86_emulate.c
> > >> @@ -0,0 +1,1370 @@
> > >> +/**********************************************************************
> > >>******** + * x86_emulate.c
> > >> + *
> > >> + * Generic x86 (32-bit and 64-bit) instruction decoder and emulator.
> > >> + *
> > >> + * Copyright (c) 2005 Keir Fraser
> > >> + *
> > >> + * Linux coding style, mod r/m decoder, segment base fixes, real-mode
> > >> + * privieged instructions:
> > >> + *
> > >> + * Copyright (C) 2006 Qumranet
> > >> + *
> > >> + *   Avi Kivity <avi@qumranet.com>
> > >> + *   Yaniv Kamay <yaniv@qumranet.com>
> > >> + *
> > >> + * From: xen-unstable 10676:af9809f51f81a3c43f276f00c81a52ef558afda4
> > >> + */
> > >
> > > This needs GPL, I'd say.
> > > 									Pavel
> >
> > The entire patchset is GPL'ed.  Do you mean to make it explicit?  If so,
> > how?  I'd rather not copy the entire license into each file.
> >
> > Doesn't ../../COPYING cover it, presuming it's accepted?
> 
> I think Pavel references to these lines...
> 
> /*
>  *  This program is free software; you can redistribute it and/or modify
>  *  it under the terms of the GNU General Public License as published by
>  *  the Free Software Foundation; either version 2 of the License, or
>  *  (at your option) any later version.
>  *
>  *  This program is distributed in the hope that it will be useful,
>  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  *  GNU General Public License for more details.
>  *
>  *  You should have received a copy of the GNU General Public License
>  *  along with this program; if not, write to the Free Software
>  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>  */
> 
> You should at least add a line like "This file is licensed under the terms of 
> the GPL v2 license (or any later version).".

There is a problem with this boiler-plate that should get fixed:  the
FSF no longer resides at that address, they've moved.  The new address
is:

Free Software Foundation
51 Franklin Street, Fifth Floor
Boston, MA 02110-1301
USA


-- 
David Bristow
djbristow@optonline.net


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUEFPV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUEFPV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUEFPV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:21:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:11747 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262574AbUEFPV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:21:57 -0400
Date: Thu, 6 May 2004 08:21:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Zephaniah E. Hull" <warp@mercury.d2dc.net>
Cc: eric.valette@free.fr, linux-kernel@vger.kernel.org
Subject: Re: RE : 2.6.6-rc3-mm2 : REGPARAM forced => no external module with
 some object code only
Message-Id: <20040506082132.05686482.akpm@osdl.org>
In-Reply-To: <20040506124454.GA12921@babylon.d2dc.net>
References: <4098D65D.9010107@free.fr>
	<20040505131809.10bdcae6.akpm@osdl.org>
	<20040506124454.GA12921@babylon.d2dc.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zephaniah E. Hull" <warp@mercury.d2dc.net> wrote:
>
> On Wed, May 05, 2004 at 01:18:09PM -0700, Andrew Morton wrote:
> > Eric Valette <eric.valette@free.fr> wrote:
> > >
> > > The Changelog says nothing really important but forcing REGPARAM is 
> > >  rather important : it breaks any external module using object only code 
> > >  that calls a kernel function.
> > 
> > This is why we should remove the option - to reduce the number of ways in
> > which the kernel might have been built.  Yes, there will be a bit of
> > transition pain while these people catch up.
> 
> Any guess on when REGPARAM and 4KSTACKS will end up in Linus' tree?

Tomorrow?  Linus will probably have some opinions on that, but if we're
going to do this thing we need to do it early in the cycle.


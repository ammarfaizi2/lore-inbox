Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270499AbTHGP0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270489AbTHGPZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:25:16 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:61915 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270359AbTHGPXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:23:51 -0400
Date: Thu, 7 Aug 2003 17:21:11 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Rankin <rankincj@yahoo.com>, tigran@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
Message-ID: <20030807152111.GF7094@louise.pinerecords.com>
References: <20030807143831.73389.qmail@web40603.mail.yahoo.com> <1060267992.3168.70.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060267992.3168.70.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> On Iau, 2003-08-07 at 15:38, Chris Rankin wrote:
> > July 2000, and my current BIOS just doesn't have any
> > microcode for them. Without the update, I used to come
> > back at the end of the day, switch on the KVM and be
> > unable to use the keyboard and mouse.
> 
> Sounds believable

Sure does.  There are machines (like the HP tc2100) which
always freeze entirely as soon as a PS/2 keyboard is attached.

> > > it can load it very early after that from initrd.
> > 
> > OK, I'll look into that.
> 
> Looking at it you can do it in initrd fine, or you can do it
> as the first thing you do once the real root fs is mounted
> from init's scripts (/etc/rc.sysinit normally)

and /etc/rc.d/rc.S on BSDish systems I believe.

-- 
Tomas Szepe <szepe@pinerecords.com>

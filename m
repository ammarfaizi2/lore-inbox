Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267550AbUBRRO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUBRRO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:14:58 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:34711
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S267550AbUBRROx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:14:53 -0500
Date: Wed, 18 Feb 2004 12:25:23 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
Message-ID: <20040218122523.A17548@animx.eu.org>
References: <402A887D.7030408@t-online.de> <402EDBA8.4070102@lovecn.org> <402F42DE.5090308@t-online.de> <20040217184132.541a5a76.rusty@rustcorp.com.au> <20040217202839.A16590@animx.eu.org> <40332666.60703@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <40332666.60703@t-online.de>; from Harald Dunkel on Wed, Feb 18, 2004 at 09:46:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>Most users don't want to remember that it's ip_conntrack but uhci-hcd.
> > 
> > I'd like to chime in about this.
> > 
> > I'd prefer it be - all the way around (I know I can use either).  Since I
> > can ask for module uhci_hcd or uhci-hcd and get uhci-hcd.ko loaded, I've
> > been using -.  It's a bit easier to type since I don't have to hit shift for
> > each _
> > 
> 
> It is really not important here whether anybody prefers '_'
> or '-'. IMHO everybody should be free to use both, even
> within one symbol filename.

That's good.  This is pretty much all I want =)

> What I do not like is that /proc/modules lies about the
> names of the loaded modules. I can understand that you
> are not affected by this problem, because all you see is
> module-init-tools, but others _are_ affected.

I did not realize that /proc/modules lied.  From a user standpoint, it may
not be /proc/modules lying, it may be module-init-tools lying to the kernel
about the module it just loaded.  I don't know, I have not looked at the
code for module-init-tools.  I checked one of my 2.6 machines and indeed all
modules are with an _ instead of a -

When I first noticed that [eou]hci_hcd was loaded I figured all modules were
using _ now.  When I was playing with alsa it never clicked in about the -
and _.  I see now that it's _ in /proc/modules.

[OT] why is the usb drivers named with -hcd at the end anyway?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWGCScC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWGCScC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGCScC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:32:02 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:2788 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750776AbWGCScA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:32:00 -0400
From: Rob Landley <rob@landley.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: klibc and what's the next step?
Date: Mon, 3 Jul 2006 14:30:45 -0400
User-Agent: KMail/1.9.1
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       klibc@zytor.com, torvalds@osdl.org
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <44A16E9C.70000@zytor.com> <Pine.LNX.4.64.0606290156590.17704@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606290156590.17704@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607031430.47296.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 June 2006 8:04 pm, Roman Zippel wrote:
> If you are concerned about this simply keep the whole thing optional.
> Embedded application usually know their boot device and they don't need no
> fancy initramfs.

Actually, a lot of embedded applications like initramfs because it saves 
memory (a ram block device, a filesystem driver, and filesystem overhead.)  
Don't use embedded applications as a reason _not_ to do this!

BusyBox has had explicit support for initramfs (switch_root) for several 
versions now.  I pestered HPA about building a subset of BusyBox against 
klibc (and cross-compiling klibc for non-x86 platforms) at the Consumer 
Electronics Linux Forum, but haven't had time to follow up yet.

Rob
-- 
Never bet against the cheap plastic solution.

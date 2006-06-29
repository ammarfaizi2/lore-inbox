Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWF2AFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWF2AFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWF2AFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:05:06 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:39061 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751824AbWF2AFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:05:02 -0400
Date: Thu, 29 Jun 2006 02:04:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
In-Reply-To: <44A16E9C.70000@zytor.com>
Message-ID: <Pine.LNX.4.64.0606290156590.17704@scrub.home>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <p73r71attww.fsf@verdi.suse.de>
 <44A166AF.1040205@zytor.com> <200606271940.46634.ak@suse.de> <44A16E9C.70000@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Jun 2006, H. Peter Anvin wrote:

> > But not for LVM where this can be fairly complex.
> > 
> > And next would be probably iSCSI. Maybe it's better to leave some stuff
> > in initramfs. 
> 
> Of course, and even if it's built into the kernel tree it doesn't have to be
> monolithic (one binary.)  Current kinit is monolithic (although there are
> chunks available as standalone binaries, and I have gotten requests to break
> out more), but that's mostly because I've been concerned about bloating the
> overall size of the kernel image for embedded people.

If you are concerned about this simply keep the whole thing optional. 
Embedded application usually know their boot device and they don't need no 
fancy initramfs.

bye, Roman

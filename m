Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263591AbVCEBUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbVCEBUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 20:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbVCEBTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 20:19:46 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:22991 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263591AbVCEBIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:08:22 -0500
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on
	battery power)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
In-Reply-To: <20050304234149.GD2647@elf.ucw.cz>
References: <200502252237.04110.rjw@sisk.pl>
	 <200503041415.35162.rjw@sisk.pl> <20050304201109.GB2385@elf.ucw.cz>
	 <200503050026.06378.rjw@sisk.pl>  <20050304234149.GD2647@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1109985002.3772.325.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Mar 2005 12:10:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-03-05 at 10:41, Pavel Machek wrote:
> > non-RAM areas with PG_nosave, at least for sanity reasons (eg to be sure that
> > we do not break things by dumping stuff to where we should not write to).
> 
> I'm not sure if it is not better to save & restore non-RAM areas, but
> it probably just does not matter.

IIRC, it does matter. I think there were situations where you got
something nasty (MCE/oops/freeze) if you tried reading memory that
doesn't exist. If you push me I'll put the effort into looking up
suspend2 archives to find the discussion :>

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de



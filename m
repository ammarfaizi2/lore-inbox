Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTIJLvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTIJLvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:51:03 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:14474 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262591AbTIJLvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:51:01 -0400
Subject: Re: [PM] Passing suspend level down to drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Machek <pavel@suse.cz>, mochel@osdl.org, benh@kernel.crashing.org,
       axboe@suse.de, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030910161243.42808c95.sfr@canb.auug.org.au>
References: <20030909225410.GD211@elf.ucw.cz>
	 <Pine.LNX.4.44.0309091604070.695-100000@cherise>
	 <20030909230755.GG211@elf.ucw.cz>
	 <20030910161243.42808c95.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063194489.32730.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 12:48:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 07:12, Stephen Rothwell wrote:
> On another note, APM does allow for individual device power management
> (i.e. you can tell the BIOS "suspend the first disk" or "power off
> all displays").  I have been wondering if we want to disable the BIOS's
> device power management now that we are begining to do it ourselves.

APM knows more about the system than we do, certainly for laptops and it
can do stuff we can't do without ACPI. Most BIOSes also don't bother
supporting most of the "suspend first foo", or for that matter always
agree with us what is first.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269517AbUJFVlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269517AbUJFVlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269504AbUJFVlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:41:40 -0400
Received: from relay.pair.com ([209.68.1.20]:24332 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269531AbUJFVjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:39:37 -0400
X-pair-Authenticated: 68.42.66.6
Subject: Re: PROBLEM: shutdown fails with 2.6.9-rc3
From: Daniel Gryniewicz <dang@fprintf.net>
To: Charles Johnston <charles@infoplatter.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097093201.3008.2.camel@mercury>
References: <1097090983.10141.3.camel@athena.fprintf.net>
	 <1097093201.3008.2.camel@mercury>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 06 Oct 2004 17:39:35 -0400
Message-Id: <1097098775.9535.0.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 14:06 -0600, Charles Johnston wrote:
> On Wed, 2004-10-06 at 13:29, Daniel Gryniewicz wrote:
> > Hi, all.
> > 
> > I just upgraded to 2.6.9-rc3 from a 2.6.8.1 based kernel, and my laptop
> > is no longer powering off.  Sometimes, the screen powers off, sometimes
> > it sits there saying "Power Down",  but in either case, the power LED is
> > still lit, and a hard power-off is necessary.  This did not happen with
> > 2.6.8.1.  I tried booting with acpi=off (as there was a report of
> > shutdown weirdness due to acpi on 2.6.9-rc1), but that did not help.
> > 
> > I have a Dell Inspiron 8600 laptop, with a Pentium-M 1500, and Centrino
> > chipset.  Attached is lscpi, cpuinfo, /proc/modules, and config for the
> > 2.6.9-rc3 kernel that fails.
> > 
> > Linux version 2.6.9-rc3 (dang@athena) (gcc version 3.4.2 (Gentoo Linux
> > 3.4.2-r2, ssp-3.4.1-1, pie-8.7.6.5)) #1 Wed Oct 6 15:02:35 EDT 2004
> > 
> > Daniel
> 
> I have the same machine and experienced the same problem starting with
> 2.6.9-rc1.
> 
> The solution is to disable APIC and IO-APIC support.  The reason why it
> now has problems is the black-list with the Inspiron on it was removed.
> 
> 
> Charles

Thanks, that worked.

Daniel

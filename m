Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269351AbTCDKJg>; Tue, 4 Mar 2003 05:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269354AbTCDKJf>; Tue, 4 Mar 2003 05:09:35 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7684 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S269351AbTCDKJf>;
	Tue, 4 Mar 2003 05:09:35 -0500
Date: Tue, 4 Mar 2003 14:18:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mem= option for broken bioses
Message-ID: <20030304131855.GE618@zaurus.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com> <b3m840_5e4_1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3m840_5e4_1@cesium.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I've seen broken bios that did not mark acpi tables in e820
> > > tables. This allows user to override it. Please apply,
> > 
> > OK, looks reasonable. Can you also gen up a patch documenting this in
> > kernel-parameters.txt?
> > 
> 
> This is very much *NOT* reasonable.  In fact, screwing around with the
> syntax of the mem= parameter is poison.  I know it has already
> happened, and those changes need to be reverted and the new stuff
> moved to a different option.
> 
> The mem= option is unique in that it is an option that affects both
> the boot loader and the kernel.  Therefore, ITS SYNTAX MUST NOT
> CHANGE.

This should be commented, somewhere.
Why is mem= option used by boot loader?
Does your bootloader really parse stuff
like mem=exactmap?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTKMCP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 21:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTKMCP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 21:15:28 -0500
Received: from adsl-67-124-145-217.dsl.pltn13.pacbell.net ([67.124.145.217]:33920
	"EHLO top.worldcontrol.com") by vger.kernel.org with ESMTP
	id S261929AbTKMCP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 21:15:26 -0500
From: brian@worldcontrol.com
Date: Wed, 12 Nov 2003 18:16:13 -0800
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Toshiba P25-S507 laptop and freezes with 2.6.0-test9
Message-ID: <20031113021613.GA4318@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
References: <20031112182711.GA5454@top.worldcontrol.com> <20031112112849.A12974@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112112849.A12974@osdlab.pdx.osdl.net>
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * brian@worldcontrol.com (brian@worldcontrol.com) wrote:
> > My Toshiba P25-S507 P4 2.8 running vanilla 2.6.0-test9 occasionally
> > freezes.  The freezes occur during events such as closing or opening
> > the lid or removing/inserting the power adapter and sometimes during
> > halt.

On Wed, Nov 12, 2003 at 11:28:49AM -0800, Chris Wright wrote:
> These are ACPI events (at least lid and power adaptor).  So, are you
> compiling in ACPI support?  If so does it still happen with acpi=off
> kernel command line option?  Do you still have keyboard when it freezes?
> If so, alt-sysrq-p or alt-sysrq-t show anything useful?  And, finally,
> you aren't using an nVidia binary only module for that GeForce are you?

Yes I use APCI support.

Ah, I have been trying to use 'noacpi' so I guess I have failed to
turn it off.  I'll give 'acpi=off' a try.

The keyboard is as dead as the rest of the system.

I am running the nVidia binary module.  

I'll run 'acpi=off' for a week or two and then try the nv driver.

Thanks for the help,

-- 
Brian Litzinger

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUAETuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbUAETuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:50:20 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:43849 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261152AbUAETuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:50:12 -0500
Date: Mon, 5 Jan 2004 21:50:05 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jfbeam@bluetronic.net
Subject: Re: 2.6.0 under vmware ?
Message-ID: <20040105195004.GH11115091@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Stephen Hemminger <shemminger@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jfbeam@bluetronic.net
References: <1073297203.12550.30.camel@bip.parateam.prv> <20040105142032.GE11115091@niksula.cs.hut.fi> <20040105185506.GF11115091@niksula.cs.hut.fi> <20040105113003.1bf558b7.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105113003.1bf558b7.shemminger@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 11:30:03AM -0800, you [Stephen Hemminger] wrote:
> > 
> > Turns out the second floppy drive was disabled from the bios.
> > 
> > Oddly, 2.2 and 2.4 don't care.
> > 
> > If I turn the second drive on from the bios, 2.6 finds it, too.
> 
> Probably because 2.6 uses ACPI and 2.2/2.4 were not.

Sounds reasonable. 

However, booting with "acpi=off" doesn't dig up /dev/fd1. Perhaps ACPI
should be compiled out for good, but this really isn't a large problem for
me as long as the drive works when enabled in BIOS.


-- v --

v@iki.fi

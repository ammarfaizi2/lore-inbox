Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267825AbUG3UWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267825AbUG3UWi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUG3UWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:22:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38358 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267825AbUG3UU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:20:58 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 13:20:19 -0700
User-Agent: KMail/1.6.2
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
References: <20040730193546.GA328@ucw.cz> <20040730194150.7072.qmail@web14927.mail.yahoo.com> <20040730194854.GA436@ucw.cz>
In-Reply-To: <20040730194854.GA436@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301320.19892.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 12:48 pm, Vojtech Pavlik wrote:
> On Fri, Jul 30, 2004 at 12:41:50PM -0700, Jon Smirl wrote:
> > I looked at PCI quirks, they all seem to be fixing chipset issues. Do
> > we want to start including adapter specific quirks along with the more
> > general chipset one?
>
> It's mostly chipsets, but not just chipsets - take a look at the S3
> entries.

I think Martin's suggestion of just caching them all at probe time (or 
optionally at driver attach time) is probably the simplest and easiest to get 
right.  It could be controllable via a boot time parameter.  But I'm not 
entirely opposed to using pci quirks.

Jesse

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUAKJBh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUAKJBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:01:37 -0500
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:30360 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S265810AbUAKJBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:01:36 -0500
Date: Sun, 11 Jan 2004 01:01:35 -0800
From: Simon Kirby <sim@netnation.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 SMP lockups
Message-ID: <20040111090135.GB6834@netnation.com>
References: <Pine.LNX.4.58L.0401101758010.1310@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401101758010.1310@logos.cnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 05:58:18PM -0200, Marcelo Tosatti wrote:

> This sounds like a deadlock. I wonder why the NMI watchdog is not
> triggering.

It appears the box I was expecting it to work onn has issues with the NMI
working properly, so that may explain why nothing was showing up.  I'll
try on others.

> Can you share all available SysRQ-P output for the locked CPU ? SysRQ-T if
> possible, too.

Will do, in the next few days.

> Can you please describe the hardware in more detail. Is there any common
> hardware used in these boxes?

The CPUs, motherboards, SCSI, Ethernet, etc., are all different... They
are all SMP, and are fairly busy web servers.

Simon-

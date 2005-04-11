Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVDKUUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVDKUUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVDKUTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:19:08 -0400
Received: from web88002.mail.re2.yahoo.com ([206.190.37.189]:15025 "HELO
	web88002.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261951AbVDKURm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:17:42 -0400
Message-ID: <20050411201741.73077.qmail@web88002.mail.re2.yahoo.com>
Date: Mon, 11 Apr 2005 16:17:41 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [ACPI] [2.6.12-rc2][suspend] Suspending Thinkpad: drive bay light in S3 mode stays on
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, I suppose you can, but most suspend tools just
echo stuff to /sys (or still /proc/acpi/sleep) which
makes it harder to script it. Besides, when a laptop
goes into suspend to RAM there should be no extra
power   on except a Moon or some other icon.

That said, the ACPI thinkpad extras was designed to do
all of this so why shouldn't the driver do S3 suspend
if it hooks into it already?

Shawn.

--- Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, 2005-04-11 at 16:03 -0400, Shawn Starr
> wrote:
> > I notice in Linux and in XP the drive bay light
> > remains on while the laptop is in suspend-to-RAM.
> I
> > know the ACPI  thinkpad extras added to the kernel
> > recently can turn this off. I wonder if we can/or
> need
> > to write hooks to turn the light off so to
> conserve
> > power when we're in S3
> 
> Just disable it in your suspend script. There's no
> reason to push that
> sort of policy into the kernel.
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
> 
> 

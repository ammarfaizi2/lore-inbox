Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265643AbUBPQk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUBPQk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:40:26 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:45022 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265643AbUBPQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:40:25 -0500
Date: Mon, 16 Feb 2004 16:38:00 +0000
From: Dave Jones <davej@redhat.com>
To: john moser <bluefoxicy@linux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Radeon IGP drivers
Message-ID: <20040216163800.GB27470@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	john moser <bluefoxicy@linux.net>, linux-kernel@vger.kernel.org
References: <20040216162256.0272F395B@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216162256.0272F395B@sitemail.everyone.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 08:22:56AM -0800, john moser wrote:

 > Some patches are referenced at the following link for the xfree86 CVS:
 > http://www.google.com/search?q=cache:GSp4PKNHFpAJ:www.cliff.biffle.org/cpq2100.php+linux+presario+2100+3D&hl=en&ie=UTF-8
 > 
 > These patches do two things.  One allows X to use IGP drivers with DRI.  The
 > other generates a .ko for Linux 2.6 that works with the Radeon IGP cards.
 > 
 > It is the responsibility of the XFree86 project to merge in the DRI patch;
 > however, the new IGP-compatible Radeon driver
 > ( http://www.cliff.biffle.org/patches/radeon_igp-2.6.patch )
 > is a kernel driver.  Has this been moved into the Linux source tree yet?  If
 > not, could someone move it into the tree?  Better to have it now than to wait
 > for X 4.4 to come out and (possibly) have the DRI patch merged in before

patch looks totally bogus in relation to whats in kernel tree right now.
It's also got absolutely nothing to do with radeon igp, just changes
to the different agp types (which the in-kernel drivers got changed
to a long time ago).

		Dave


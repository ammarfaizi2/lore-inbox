Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752107AbWCCBC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbWCCBC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbWCCBC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:02:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14995 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752104AbWCCBC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:02:27 -0500
To: linux-kernel@vger.kernel.org
Cc: bjorn.helgaas@hp.com, ambx1@neo.rr.com, mm-commits@vger.kernel.org
Subject: Re: + pnp-mpu401-adjust-pnp_register_driver-signature.patch added
 to -mm tree
References: <200603022340.k22Neq0o014875@shell0.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Mar 2006 17:55:47 -0700
In-Reply-To: <200603022340.k22Neq0o014875@shell0.pdx.osdl.net> (akpm@osdl.org's
 message of "Thu,  2 Mar 2006 15:43:07 -0800")
Message-ID: <m1veuwgxd8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org writes:

> The patch titled
>
>      pnp: mpu401: adjust pnp_register_driver signature
>
> has been added to the -mm tree.  Its filename is
>
>      pnp-mpu401-adjust-pnp_register_driver-signature.patch
>
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
>
>
> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
> This series of patches removes the assumption that pnp_register_driver()
> returns the number of devices claimed.  Returning the count is unreliable
> because devices may be hot-plugged in the future.  (Many devices don't support
> hot-plug, of course, but PNP in general does.)

Huh?

How do onboard devices or ISA plug and play devices support hot-plug?

Or what devices supported by the pnp subsystem support hot-plug?

This may be a reasonable cleanup, but I'm worried about justifying it
with supporting hardware that does not exist.

Eric

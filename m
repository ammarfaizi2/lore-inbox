Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267160AbUBMUU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUBMUUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:20:55 -0500
Received: from dsl-082-083-130-200.arcor-ip.net ([82.83.130.200]:26502 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S267160AbUBMUUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:20:54 -0500
Date: Fri, 13 Feb 2004 21:20:52 +0100
From: Dominik Kubla <dominik@kubla.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Dominik Kubla <dominik@kubla.de>,
       Emmeran Seehuber <rototor@rototor.de>
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Message-ID: <20040213202052.GA1283@intern.kubla.de>
References: <200402112344.23378.rototor@rototor.de> <20040213070333.GA1555@intern.kubla.de> <200402130223.00339.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402130223.00339.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 02:23:00AM -0500, Dmitry Torokhov wrote:
> 
> Do you have an active multiplexing controller and does passing i8042.nomux 
> option help?

The Debian maintainer released a new package today with the following change
log entry:

* Reenabled INPUT_MOUSEDEV_PSAUX_ENABLE (closes: #232267, #232269).

Now everything works again.

So it looks like this might have been a SNAFU... Unless the other guy
experiencing problems is not using the Debian kernel packages.

Sorry for not passing along that i was using a pre-compiled binary.

Regards,
  Dominik
-- 
BOFH excuse #203:

Write-only-memory subsystem too slow for this machine. Contact your local dealer.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRCFU07>; Tue, 6 Mar 2001 15:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129635AbRCFU0t>; Tue, 6 Mar 2001 15:26:49 -0500
Received: from mail630.gsfc.nasa.gov ([128.183.190.39]:7180 "EHLO
	mail630.gsfc.nasa.gov") by vger.kernel.org with ESMTP
	id <S129464AbRCFU0h>; Tue, 6 Mar 2001 15:26:37 -0500
Date: Tue, 6 Mar 2001 15:26:28 -0500
From: John Kodis <kodis@mail630.gsfc.nasa.gov>
To: Jeff Coy <jcoy@klah.net>
Cc: Peter Samuelson <peter@cadcamlab.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_script and ^M
Message-ID: <20010306152628.A10091@tux.gsfc.nasa.gov>
Mail-Followup-To: John Kodis <kodis@mail630.gsfc.nasa.gov>,
	Jeff Coy <jcoy@klah.net>, Peter Samuelson <peter@cadcamlab.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010306121510.A28368@cadcamlab.org> <Pine.LNX.4.10.10103061126490.27694-100000@aahz.klah.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10103061126490.27694-100000@aahz.klah.net>; from jcoy@klah.net on Tue, Mar 06, 2001 at 11:36:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 11:36:29AM -0700, Jeff Coy wrote:

> '#!/usr/bin/perl -w^M' works without any special handling; the link is
> not needed:

This is the main reason that I think that the kernel should treat \r
as just another whitespace character: it's what most shells do, it's
what most users expect, and it's the least surprising behavior.

-- 
John Kodis <kodis@acm.org>
Phone: 301-286-7376

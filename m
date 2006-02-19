Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWBSQxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWBSQxa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 11:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWBSQxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 11:53:30 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:6044 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932115AbWBSQxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 11:53:30 -0500
Date: Sun, 19 Feb 2006 08:53:10 -0800
From: Greg KH <gregkh@suse.de>
To: Tomek Koprowski <tomek@koprowski.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] SMBus unhide on HP Compaq nx6110
Message-ID: <20060219165310.GA1908@suse.de>
References: <200602191143.55507.tomek@koprowski.org> <20060219163212.GA20490@suse.de> <200602191745.36628.tomek@koprowski.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602191745.36628.tomek@koprowski.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 05:45:36PM +0100, Tomek Koprowski wrote:
> Hi,
> I attach a trivial patch for 2.6.15.4 that unhides SMBus controller
> on an HP Compaq nx6110 notebook.
> 
> Regards,
> Tomasz Koprowski
> 
> Signed-off-by: Tomasz Koprowski <tomek@koprowski.org>
> 
> --- linux-2.6.15.4.orig/drivers/pci/quirks.c ? ?2006-02-19 10:02:08.000000000 +0100
> +++ linux-2.6.15.4/drivers/pci/quirks.c 2006-02-19 10:35:04.000000000 +0100
> @@ -934,6 +934,12 @@
> ? ? ? ? ? ? ? ? ? ? ? ? case 0x12bd: /* HP D530 */

Hm, your email client seems to have messed up the tabs here.

Care to retry?

thanks,

greg k-h

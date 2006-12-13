Return-Path: <linux-kernel-owner+w=401wt.eu-S964869AbWLMOgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWLMOgO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWLMOgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:36:14 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:7426 "EHLO
	hansmi.home.forkbomb.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964973AbWLMOgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:36:13 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 09:36:13 EST
Date: Wed, 13 Dec 2006 15:29:30 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: drivers/video/aty/radeon_backlight.c
Message-ID: <20061213142930.GA12686@hansmi.ch>
References: <m3irgflxh4.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3irgflxh4.fsf@lugabout.jhcloos.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 08:46:24AM -0500, James Cloos wrote:
> Are there any dependencies in $subject which would preclude changing
> drivers/video/Kconfig with:

Yes.

> or is radeon_backlight.c only functional when -DCONFIG_PMAC_BACKLIGHT,
> even though the pmac routines are all ifdef'ed?

Did you actually test wether it works? As far as I know, only Apple
(PowerPC) hardware uses these registers yet and have no use anywhere
else.

Greets,
Michael

-- 
Gentoo Linux developer, http://hansmi.ch/, http://forkbomb.ch/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVBGDly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVBGDly (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVBGDly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:41:54 -0500
Received: from colo.lackof.org ([198.49.126.79]:8836 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261339AbVBGDlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:41:51 -0500
Date: Sun, 6 Feb 2005 20:42:19 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Enrico Bartky <DOSProfi@web.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Maarten Deprez <maartendeprez@scarlet.be>, Greg KH <gregkh@suse.de>
Subject: Re: M7101
Message-ID: <20050207034219.GA5620@colo.lackof.org>
References: <41DC59A4.1070006@web.de> <20050206152615.1ab7498c.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206152615.1ab7498c.khali@linux-fr.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 03:26:15PM +0100, Jean Delvare wrote:
> Maarten Deprez then converted it to the proper kernel coding-style:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110726276414532
...
> Any chance we could get the PCI folks to review the code and push it
> upwards if it is OK?

I'm not the maintainer, but it looks fine to me except for use
of numeric constants (e.g 0x5f, 0x18) instead of adding #defines
to name the values. But if no one knows what those offsets are for
we'll just have to leave it.


> For reference, here are links to the original m7101 unhiding driver code
> and help file:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/hotplug/m7101.c

Unfortunately, I didn't anything documenting 0x5f and 0x18.

Will m7101.c be modified once quirks enabling the device?

hth,
grant

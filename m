Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVEDVFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVEDVFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVEDVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:05:05 -0400
Received: from amber.ccs.neu.edu ([129.10.116.51]:12235 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S261560AbVEDVCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:02:04 -0400
Date: Wed, 4 May 2005 17:01:55 -0400 (EDT)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: vortex@scyld.com
cc: Bogdan.Costescu@iwr.uni-heidelberg.de, linux-kernel@vger.kernel.org
Subject: Re: strange 3c59x behaviour under 2.6.11.7
In-Reply-To: <Pine.LNX.4.44.0505031057380.9939-100000@kenzo.iwr.uni-heidelberg.de>
Message-ID: <Pine.GSO.4.58.0505041639400.5735@denali.ccs.neu.edu>
References: <Pine.LNX.4.44.0505031057380.9939-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some background for the linux-kernel folks:

http://www.scyld.com/pipermail/vortex/2005-May/002483.html

http://www.scyld.com/pipermail/vortex/2005-May/002484.html

On Tue, 3 May 2005, Bogdan Costescu wrote:

> > Any ideas on what is causing this problem, and how to fix it?
>
> Try booting with acpi=off.
> Try updating BIOS and/or modify power related options in BIOS.

I've tried disabling ACPI in the kernel, turning on APM support in the
BIOS, and the combination of the two, and unfortunately the problem
persisted.

However, I found this patch (the one at the very bottom of the page):
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg78894.html

And after adapting it to the 2.6.11.7 kernel, everything works again!
I've rebooted the machine several times, and the 3com cards initialized
successfully every time.

I'm CC'ing linux-kernel in the hopes that this fix can make it into the
mainstream kernel sometime soon.  I'm sure my mother would appreciate it
greatly. :)

Please CC my e-mail address in any replies as I am not subscribed to this
list.

thanks,
Jim Faulkner

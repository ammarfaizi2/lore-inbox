Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVCDRuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVCDRuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVCDRuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:50:51 -0500
Received: from orb.pobox.com ([207.8.226.5]:19846 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262935AbVCDRuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:50:46 -0500
Date: Fri, 4 Mar 2005 09:50:39 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       mjg59@scrf.ucam.org, hare@suse.de
Subject: Re: swsusp: allow resume from initramfs
Message-ID: <20050304175038.GE9796@ip68-4-98-123.oc.oc.cox.net>
References: <20050304101631.GA1824@elf.ucw.cz> <20050304030410.3bc5d4dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304030410.3bc5d4dc.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:04:10AM -0800, Andrew Morton wrote:
> I don't understand how this can be affected by the modularness of the
> kernel.  Can you explain a little more?
> 
> Would it not be simpler to just add "resume=03:02" to the boot command line?

In addition to what others have mentioned, there's also the situation
where swap is on a logical volume. In that case, the initramfs needs to
get LVM up and running before you can even think about resuming.

Swap on a logical volume is the default Fedora Core 3 partition layout,
and I imagine it's the default for Red Hat Enterprise Linux 4 as well.

-Barry K. Nathan <barryn@pobox.com>


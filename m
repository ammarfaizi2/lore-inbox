Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbULFQ72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbULFQ72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbULFQ71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:59:27 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:22182 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261568AbULFQ7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:59:08 -0500
Date: Mon, 6 Dec 2004 11:59:29 -0500
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Matthieu Castet <castet.matthieu@free.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9+] PnPBIOS: Missing SMALL_TAG_ENDDEP tag
Message-ID: <20041206165929.GE3103@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Rene Herman <rene.herman@keyaccess.nl>,
	Matthieu Castet <castet.matthieu@free.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41B3A963.4090003@keyaccess.nl> <20041206024218.GD3103@neo.rr.com> <41B3CCA6.1060507@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B3CCA6.1060507@keyaccess.nl>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 04:06:14AM +0100, Rene Herman wrote:
> Adam Belay wrote:
> 
> >Could you please send me "pnp.tar" from something like this:
> >
> >mkdir /tmp/pnp; cp /proc/bus/pnp/[0-f][0-f] /tmp/pnp; tar -cf pnp.tar 
> >/tmp/pnp; rm -fR /tmp/pnp
> >
> >make sure the pnpbios /proc interface is compiled into the kernel.
> >
> >I'd like to look at the node data to see what's going on.
> 
> Sure, attached. In case it's useful/easier, earlier I also booted with 
> debugging printks added to pnpbios_parse_resource_option_data, noting 
> the tag types encountered. This produced:
>

I appreciate the additional information.  I looked through the binary files
manually and confirmed that they are missing an end-dep tag.  It should be
harmless however.  I think the error message needs to be debug or it could 
be removed.

Thanks,
Adam

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbULGADF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbULGADF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbULGADF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:03:05 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:12458 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261707AbULGADA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:03:00 -0500
Date: Mon, 6 Dec 2004 19:03:19 -0500
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Matthieu Castet <castet.matthieu@free.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9+] PnPBIOS: Missing SMALL_TAG_ENDDEP tag
Message-ID: <20041207000319.GA19103@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Rene Herman <rene.herman@keyaccess.nl>,
	Matthieu Castet <castet.matthieu@free.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41B3A963.4090003@keyaccess.nl> <20041206024218.GD3103@neo.rr.com> <41B3CCA6.1060507@keyaccess.nl> <20041206165929.GE3103@neo.rr.com> <41B4C95D.7030507@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B4C95D.7030507@keyaccess.nl>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 10:04:29PM +0100, Rene Herman wrote:
> Adam Belay wrote:
> 
> >I appreciate the additional information.  I looked through the binary files
> >manually and confirmed that they are missing an end-dep tag.  It should be
> >harmless however.  I think the error message needs to be debug or it could 
> >be removed.
> 
> As far as I'm concerned, making it debug is not too useful. I normally 
> have pnp debug enabled but not to debug my BIOS.
> 
> Hence attachment. Could you push it on yourself if you agree? Thanks...
> 
> Rene.
> 
>

Even if there is a problematic usage of dep tags, the possible resource list
will reflect it, so I'm fine with removing the message.  Thanks for the patch.

Adam


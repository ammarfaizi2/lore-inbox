Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVJCVWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVJCVWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVJCVWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:22:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:13985 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932408AbVJCVWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:22:23 -0400
Date: Mon, 3 Oct 2005 14:22:00 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Paul Jackson <pj@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document patch subject line better
Message-ID: <20051003212200.GA28300@kroah.com>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com> <Pine.LNX.4.64.0510030805380.31407@g5.osdl.org> <20051003085414.05468a2b.pj@sgi.com> <20051003160452.GA9107@kroah.com> <20051003230235.55516671.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003230235.55516671.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 11:02:35PM +0200, Jean Delvare wrote:
> This only prevents quilt from stripping the "---" line, it does NOT
> add the line if it's not there. Doing so would require template
> support, I know many users are interested and a few implementations
> exist, waiting to be merged upstream, but it's not there right now.
> 
> Greg, if you have a better fix, just send it to the quilt-dev and I'll
> get it applied.

No, my fix just always added it.  I was just going to make that addition
optional based on a config option.  But your patch is also needed to
make sure it gets handled properly (I did something much like this, but
messier...)

thanks,

greg k-h

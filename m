Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWHCHX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWHCHX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWHCHX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:23:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4067 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932365AbWHCHXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:23:55 -0400
Date: Thu, 3 Aug 2006 00:19:22 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Linux 2.6.17.6
Message-ID: <20060803071922.GO26354@kroah.com>
References: <20060715193552.GA5330@kroah.com> <1153009083.12764.18.camel@localhost> <1153009253.12764.20.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153009253.12764.20.camel@localhost>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 02:20:53AM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > > This should fix the reported issue of NetworkManager dying when using
> > > the 2.6.17.5 kernel release.  All users of the 2.6.17 kernel are
> > > recommended to upgrade to this kernel, as it fixes a publicly known
> > > security issue that can provide root access to any local user of the
> > > machine.
> > 
> > attached is the backported "don't allow chmod()" patch. Please consider
> > including it into the next stable release. Since the 2.6.17.6 kernel is
> > no longer vulnerable against CVE-2006-3626, this has no real urgent need
> > to get out.
> 
> actually attaching the patch might help ;)

Queued to -stable.

thanks,

greg k-h


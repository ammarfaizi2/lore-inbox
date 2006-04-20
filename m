Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWDTWVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWDTWVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWDTWVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:21:48 -0400
Received: from ns1.suse.de ([195.135.220.2]:16777 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932086AbWDTWVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:21:47 -0400
Date: Thu, 20 Apr 2006 15:20:20 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: patrakov@ums.usu.ru, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.16.7
Message-ID: <20060420222020.GF14441@kroah.com>
References: <44448DFF.3080108@ums.usu.ru> <20060418153951.GC30485@kroah.com> <4445BB0F.6010305@ums.usu.ru> <20060418.214121.80350811.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418.214121.80350811.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 09:41:21PM -0700, David S. Miller wrote:
> From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
> Date: Wed, 19 Apr 2006 10:22:39 +0600
> 
> > Without that patch, there is a race when registering network interfaces 
> > and renaming it with udev rules, because initially the "address" in 
> > sysfs doesn't contain useful data. See 
> > http://marc.theaimsgroup.com/?t=114460338900002&r=1&w=2
> > 
> > Breaking the recommended way of assigning persistent network interface 
> > names is, IMHO, a bug serious enough to be fixed in -stable.
> > 
> > Signed-off-by: Alexander E. Patrakov <patrakov@ums.usu.ru>
> 
> I've been waiting to see if there is any negative fallout
> from this change, but I guess it's OK for stable.

Thanks for the ack.

Queued to -stable, thanks.

greg k-h


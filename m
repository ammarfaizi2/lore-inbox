Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVDGIV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVDGIV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVDGITb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:19:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:1710 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262314AbVDGISH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:18:07 -0400
Date: Thu, 7 Apr 2005 01:17:19 -0700
From: Greg KH <greg@kroah.com>
To: johnpol@2ka.mipt.ru
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: connector is missing in 2.6.12-rc2-mm1
Message-ID: <20050407081718.GA4402@kroah.com>
References: <1112855509.18360.27.camel@frecb000711.frec.bull.fr> <20050406234257.460edb9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050406234257.460edb9a.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 11:42:57PM -0700, Andrew Morton wrote:
> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> >
> > Hello,
> > 
> >  I don't see the connector directory in the 2.6.12-rc2-mm1 tree. So it
> > seems that you removed the connector?
> 
> Greg dropped it for some reason.  I think that's best because it needed a
> significant amount of rework.  I'd like to see it resubitted in totality so
> we can take another look at it.

Greg dropped it because he's radically changing the way he handles
patches.  I still have them around here somewhere...

Yeah, here they are.  Hm, I'd really like to stop carrying them around,
as my workload doesn't lend itself to handling these.

If you don't mind, can you create up a new connector, super-io, and
kobject-connector patch and send them to andrew for him to add to -mm?
That way I'll not have to worry about them anymore, as they keep
floating in-and-out of the -mm releases depending on the state of my
trees.  I can still handle your w1 patches, and have 2 of them pending.

Is that ok with you?

thanks,

greg k-h

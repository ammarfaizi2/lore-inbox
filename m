Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263051AbTCSQYB>; Wed, 19 Mar 2003 11:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263050AbTCSQYB>; Wed, 19 Mar 2003 11:24:01 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:43268 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S263051AbTCSQYA>; Wed, 19 Mar 2003 11:24:00 -0500
Date: Wed, 19 Mar 2003 19:34:04 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Brownell <david-b@pacbell.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       usb-devel <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5.65] ehci-hcd, don't use PCI MWI
Message-ID: <20030319193404.A1025@jurassic.park.msu.ru>
References: <3E788B06.4090302@pacbell.net> <20030319153421.GA26181@gtf.org> <3E78927F.4060600@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E78927F.4060600@pacbell.net>; from david-b@pacbell.net on Wed, Mar 19, 2003 at 07:53:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 07:53:35AM -0800, David Brownell wrote:
> Jeff Garzik wrote:
> > Please don't -- Ivan has a patch for this, let's get that in instead.
> 
> I'd be happy with that, except on the 2.4 trees where we haven't
> seen such a patch yet.  (So Greg -- please hold off on this
> for 2.5 unless/until it becomes clear Ivan's patch won't happen.)

Hopefully I'll post the updated patch tomorrow.
Right now I'm chasing down weird problem - 2.5.65 broke networking
on one of my boxes. So far I figured out that reverting serial/core
changes fixes that. Incredibly...

Ivan.

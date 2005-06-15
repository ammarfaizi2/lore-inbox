Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVFOQwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVFOQwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVFOQwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 12:52:30 -0400
Received: from mail1.kontent.de ([81.88.34.36]:13734 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261216AbVFOQw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 12:52:28 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Wakko Warner <wakko@animx.eu.org>
Subject: Re: Problem found: kaweth fails to work on 2.6.12-rc[456]
Date: Wed, 15 Jun 2005 18:52:25 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050612004136.GA8107@animx.eu.org> <200506151330.02486.oliver@neukum.org> <20050615165358.GA10993@animx.eu.org>
In-Reply-To: <20050615165358.GA10993@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506151852.25582.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 15. Juni 2005 18:53 schrieb Wakko Warner:
> Oliver Neukum wrote:
> > > I meant I didn't know the name to number translation.
> > 
> > Sorry, ENOENT.
> 
> Ok.
> 
> > > For the next tests, I think it would be best to remove the 3 printks I added
> > > to show beginning, u->status, and ending.  Spews too much stuff =)
> > 
> > Please do so and try removing and reattaching the cable.
> 
> I removed the printks that were spewing lines that are now no longer useful. 
> I left the ones that are in the block for the if statement.   There is no
> change when I unplug and replug the ethernet cable.  The link light on the
> device does go off.  Is it possible that the hardware cannot report link
> state?

It is unfortunately possible. It is even more unfortunately a violation
of the specifications I've got from the manifacturer. Even worse, I don't
know which devices have a working link detection and which don't.
This means that I'll make a patch disabling it for all for the time being.

	Regards
		Oliver

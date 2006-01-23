Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWAWMwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWAWMwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWAWMwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:52:22 -0500
Received: from cantor2.suse.de ([195.135.220.15]:31428 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751351AbWAWMwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:52:22 -0500
From: Andi Kleen <ak@suse.de>
To: Martin Waitz <tali@admingilde.org>
Subject: Re: Fixing make mandocs
Date: Mon, 23 Jan 2006 13:52:23 +0100
User-Agent: KMail/1.8
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
References: <200601230531.27609.ak@suse.de> <20060122205349.0ec46cbe.rdunlap@xenotime.net> <20060123122831.GC11002@admingilde.org>
In-Reply-To: <20060123122831.GC11002@admingilde.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601231352.24068.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 13:28, Martin Waitz wrote:
> hoi :)
>
> On Sun, Jan 22, 2006 at 08:53:49PM -0800, Randy.Dunlap wrote:
> > > > > Here would be a good janitor task for 2.6.16. make mandocs
> > > > > currently doesn't build because a number of descriptions are
> > > > > missing parameters etc.  It would be good if someone could fix
> > > > > that and submit patches for 2.6.16.
>
> the thing that really breaks the build is the new __copy_to_user
> prototype which kernel-doc could not understand.
> This is fixed in my tree.
>
> > > Ok good. Are they going into 2.6.16?
>
> I'll try to get at least the one kernel-doc fix into 2.6.16.

I would just send all that fix build failures.

-Andi


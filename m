Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVEXAdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVEXAdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVEXAdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:33:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:45461 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261224AbVEXAdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:33:35 -0400
Date: Mon, 23 May 2005 17:34:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Stewart <andystewart@comcast.net>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: enable-reads-on-plextor-712-sa-on-26115.patch added to -mm tree
Message-Id: <20050523173420.22281325.akpm@osdl.org>
In-Reply-To: <4292743C.4040409@comcast.net>
References: <200505232245.j4NMjtk4024089@shell0.pdx.osdl.net>
	<4292628E.4090209@pobox.com>
	<4292743C.4040409@comcast.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Stewart <andystewart@comcast.net> wrote:
>
> > 
> > Good show.
> 
> Aw, come on, Jeff.  I gave it a shot,

You did, and that's very much appreciated, thanks.

> If you believe this patch is
> inappropriate, then please ask Andrew Morton to remove it

I already have removed it, but only because it appears that the patch might
cause regressions in other areas.

Basically it goes like this:

- Someone sends a patch

- Patch gets ignored.

- I merge it, without even looking at the thing.

I do this as a reminder to myself and to other developers that there is
some kernel bug or shortcoming.  Basically, it's a bug-tracking system. 
Periodically I'll spam the maintainer with the patch and eventually he'll
tell me to drop the thing because the problem is fixed, or he'll tell the
originator why the patch will never be merged.

Either way, the patch (and the problem which caused you to write the patch)
gets some sort of definite dispositive handling, rather than falling
through a crack.

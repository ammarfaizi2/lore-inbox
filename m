Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTKON1e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 08:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTKON1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 08:27:34 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27152 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261746AbTKON1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 08:27:33 -0500
Date: Sat, 15 Nov 2003 08:16:44 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <20031113122039.GJ4441@suse.de>
Message-ID: <Pine.LNX.3.96.1031115081442.2903D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Jens Axboe wrote:

> On Thu, Nov 13 2003, Bill Davidsen wrote:

> > Are there any cases when the last_written size is really what's wanted,
> > rather than the capacity? Such as unclosed multi-session iso9660, ufs, or
> > whatever else I'm ignoring?
> 
> Yes, for packet written media.

Thanks, the recent patch addresses that, I think that covers the cases
which want the last_written size. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


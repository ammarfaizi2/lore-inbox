Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266416AbUBLNkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 08:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266417AbUBLNkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 08:40:45 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:481 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S266416AbUBLNkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 08:40:43 -0500
Date: Thu, 12 Feb 2004 14:40:22 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Erik Hensema <erik@hensema.net>
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: reiserfs for bkbits.net?
Message-ID: <20040212134022.GC8705@louise.pinerecords.com>
References: <200402111523.i1BFNnOq020225@work.bitmover.com> <slrnc2ktre.4t9.erik@bender.home.hensema.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnc2ktre.4t9.erik@bender.home.hensema.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb-11 2004, Wed, 18:41 +0000
Erik Hensema <erik@hensema.net> wrote:

> The FS has been stable for a while now and I currently don't see
> any reason not to use it.

During the last two years, we have deployed some 400+ linux firewall
machines, all of which use reiserfs 3.6 for all of their filesystems.
While some of these boxes live in very wild environments (attics,
cellars, under the bed, in public block-of-flats corridors, ...) and
we've seen hardware die, there have been zero filesystem problems.
I think I can say we're happy with how reiser3 has fared so far.

Sounds a bit like from your favorite marketing department,
but still I thought you might want to know.

-- 
Tomas Szepe <szepe@pinerecords.com>

P.S.  It's also very nice to never have to fsck (that is unless
a broken driver/hardware writes random crap directly to the block
device).

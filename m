Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbUDDXBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 19:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbUDDXBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 19:01:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:43942 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262916AbUDDXB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 19:01:26 -0400
Subject: Re: [PANIC] ohci1394 & copy large files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <bcollins@debian.org>
Cc: Marcel Lanz <marcel.lanz@ds9.ch>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040404141339.GW13168@phunnypharm.org>
References: <20040404141600.GB10378@ds9.ch>
	 <20040404141339.GW13168@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1081119623.1285.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Apr 2004 09:00:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 00:13, Ben Collins wrote:
> On Sun, Apr 04, 2004 at 04:16:00PM +0200, Marcel Lanz wrote:
> > Since 2.6.4 and still in 2.6.5 I get regurarly a Kernel panic if I try
> > to backup large files (10-35GB) to an external attached disc (200GB/JFS) via ieee1394/sbp2.
> > 
> > Has anyone similar problems ?
> 
> Known issue, fixed in our repo. I still need to sync with Linus once I
> iron one more issue and merge some more patches.

Hi Ben !

I don't want to be too critical or harsh or whatever, but why don't you
just send such fixes right upstream instead of stacking patches for a
while in your repo ? From my experience, such "batching" of patches is
the _wrong_ thing to do, and typically, there is a major useability
issue with sbp2 that could have been "right" in 2.6.5 final and will not
be (so we'll have to wait what ? 1 or 2 monthes more now to have a
release kernel with a reliable sbp2)

Ben.



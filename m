Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUDLSI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 14:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUDLSI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 14:08:27 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:62469 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S263000AbUDLSI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 14:08:26 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Date: Mon, 12 Apr 2004 20:03:23 +0200
User-Agent: KMail/1.5.2
Cc: Ivica Ico Bukvic <ico@fuse.net>, "'Tim Blechmann'" <TimBlechmann@gmx.net>,
       "'Thomas Charbonnel'" <thomas@undata.org>, ccheney@debian.org,
       linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20040412082801.A3972@flint.arm.linux.org.uk> <200404121731.20765.daniel.ritz@gmx.ch> <20040412163854.C12980@flint.arm.linux.org.uk>
In-Reply-To: <20040412163854.C12980@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404122003.23997.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 April 2004 17:38, Russell King wrote:
> On Mon, Apr 12, 2004 at 05:31:20PM +0200, Daniel Ritz wrote:
> > EnE datasheet says it's also available in EnE 1211, 1225, 1420.
> > and since they are TI clones why not for the TI's too?
> 
> Because the register supposedly does not exist on TI - it's likely to be
> EnE specific.
> 
> I'm willing to bet that TI chips will behave as expected without touching
> 0xc9 at all.

you win. just booted my TI1410 laptop . 0xc9 is 0 and read-only.
so the EnE's are not 100% TI clone...


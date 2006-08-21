Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422684AbWHUQDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWHUQDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 12:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbWHUQDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 12:03:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:26838 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422684AbWHUQDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 12:03:34 -0400
From: Andi Kleen <ak@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Mon, 21 Aug 2006 18:03:28 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060820013121.GA18401@fieldses.org> <200608201026.54530.ak@suse.de> <20060821155431.GA3678@fieldses.org>
In-Reply-To: <20060821155431.GA3678@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211803.28867.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 August 2006 17:54, J. Bruce Fields wrote:
> On Sun, Aug 20, 2006 at 10:26:54AM +0200, Andi Kleen wrote:
> > 
> > > DWARF2 unwinder stuck at 0xc0100199
> > > Leftover inexact backtrace:
> > >  =======================
> > >  BUG: unable to handle kernel paging request at virtual address 0000b034
> > 
> > This is already fixed in mainline.
> 
> I'm seeing the same behavior on Linus's latest as of this morning
> (2.6.18-rc4-gef7d1b24).  Is there something else I should be testing?

The stuck is expected, but the unable to handle paging request should be 
fixed. If not then it's a different problem than what I'm thinking,
but it looks very similar.

-Andi

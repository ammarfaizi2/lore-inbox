Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVIAQiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVIAQiP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVIAQiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:38:14 -0400
Received: from styx.suse.cz ([82.119.242.94]:46471 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030230AbVIAQiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:38:14 -0400
Date: Thu, 1 Sep 2005 18:38:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Mares <mj@ucw.cz>
Cc: Zoltan Szecsei <zoltans@geograph.co.za>, linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
Message-ID: <20050901163826.GB31158@midnight.suse.cz>
References: <4316E5D9.8050107@geograph.co.za> <20050901122253.GA11787@midnight.suse.cz> <4316FD08.1070505@geograph.co.za> <20050901132409.GA29134@midnight.suse.cz> <20050901144812.GA3483@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901144812.GA3483@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:48:12PM +0200, Martin Mares wrote:
> Hello!
> 
> > Btw, Aivils Stoss created a nice way to make several X instances have
> > separate keyboards - see the linux-console archives for the faketty
> > driver.
> 
> I haven't looked recently, but when I tried that several years ago,
> the biggest problem was to make two simultaneously running X servers
> not switch off each other's video card I/O ports off :)

That is still the biggest issue. Some modern cards don't need the legacy
I/O for working, however.

> All other things looked solvable with a reasonably small effort.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

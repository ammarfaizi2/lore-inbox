Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUFXPkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUFXPkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265685AbUFXPkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:40:11 -0400
Received: from styx.suse.cz ([82.119.242.94]:14720 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265668AbUFXPkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:40:07 -0400
Date: Thu, 24 Jun 2004 17:41:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Eger <eger@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i8042 driver non-determinantly chokes mac on boot
Message-ID: <20040624154127.GJ731@ucw.cz>
References: <20040624083910.GA14068@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624083910.GA14068@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 04:39:10AM -0400, David Eger wrote:
> Though I'm not sure I even have an i8042 (I'm guessing no, as I run
> on a Mac) the detection failure path has gone a little wonky in recent
> kernels.  Half the time it times out with the following (as it ought, 
> me thinks)
> 
> IN from bad port 64 at c01f3100
> IN from bad port 64 at c01f3100
> IN from bad port 64 at c01f3100
> IN from bad port 64 at c01f3100
> i8042.c: i8042 controller self test timeout.
> 
> But the other half of the time it stalls my machine out entirely.
> Clues?  Want my .config?
> 
> I'm running on a Titanium PowerBook3,5.
 
I suppose you should disable it, it really has no bussiness running on a
Mac. Does it write anything when it also crashes?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

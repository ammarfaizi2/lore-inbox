Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTFQWjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbTFQWjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:39:47 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:23485 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264981AbTFQWjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:39:42 -0400
Date: Wed, 18 Jun 2003 00:53:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>, davidm@hpl.hp.com,
       Riley Williams <Riley@Williams.Name>, linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030618005333.A22643@ucw.cz>
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <16111.37901.389610.100530@napali.hpl.hp.com> <20030618002146.A20956@ucw.cz> <16111.38768.926655.731251@napali.hpl.hp.com> <20030618004233.B21001@ucw.cz> <20030617234827.K32632@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030617234827.K32632@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Jun 17, 2003 at 11:48:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 11:48:27PM +0100, Russell King wrote:
> On Wed, Jun 18, 2003 at 12:42:33AM +0200, Vojtech Pavlik wrote:
> > an arch-dependent #define is needed. I don't care about the location
> > (timex.h indeed seems inappropriate, maybe the right location is
> > pcspkr.c ...), or the name, but something needs to be done so that the
> > beeps have the same sound the same on all archs.
> 
> This may be something to aspire to, but I don't think its achievable
> given the nature of PC hardware.  Some "PC speakers" are actually
> buzzers in some cases rather than real loudspeakers which give a
> squark rather than a beep.

Ok, you're right. But at least we should try to program them to the same
beep frequency.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

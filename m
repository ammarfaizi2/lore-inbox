Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVA0Lb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVA0Lb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 06:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVA0Lb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 06:31:57 -0500
Received: from ns.suse.de ([195.135.220.2]:58303 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262563AbVA0Lbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 06:31:55 -0500
Date: Thu, 27 Jan 2005 12:31:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sebastian Piechocki <sebekpi@poczta.onet.pl>
Cc: Jaco Kroon <jaco@kroon.co.za>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050127113158.GB2975@ucw.cz>
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <20050127102507.GC2702@ucw.cz> <200501271212.24143.sebekpi@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501271212.24143.sebekpi@poczta.onet.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 12:12:23PM +0100, Sebastian Piechocki wrote:
> Dnia czwartek, 27 stycznia 2005 11:25, Vojtech Pavlik napisa³:
> > On Thu, Jan 27, 2005 at 08:23:07AM +0200, Jaco Kroon wrote:
> > > Sebastian Piechocki wrote:
> > > >As I said I'm sending you mails from kernel masters:)
> > >
> > > Thanks.
> > >
> > > >If you haven't such a problem, please send them your dmesg with
> > > >i8042.debug and acpi=off.
> > >
> > > I made an alternative plan.  I applied a custom patch that gives me
> > > far less output and prevents scrolling and gets what I hope is what
> > > is required.
> >
> > ... could you just increase the timeout value to some insane amount?
> > That should take care of the AUX_LOOP output getting back only after
> > issuing the next command.
> 
> Increasing the timeout doesn't help. I've increased timout ten times and 
> the result is the same.
 
OK, in that case the BIOS i8042 emulation just interferes badly with the
real i8042 and I doubt we can do much else than keep the BIOS from
interfering.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

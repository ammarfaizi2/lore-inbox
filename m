Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVA1LBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVA1LBw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 06:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVA1LBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 06:01:51 -0500
Received: from styx.suse.cz ([82.119.242.94]:50083 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261273AbVA1LBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 06:01:50 -0500
Date: Fri, 28 Jan 2005 12:04:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jaco Kroon <jaco@kroon.co.za>
Cc: Linus Torvalds <torvalds@osdl.org>, sebekpi@poczta.onet.pl,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050128110457.GA9213@ucw.cz>
References: <200501260040.46288.sebekpi@poczta.onet.pl> <41F888CB.8090601@kroon.co.za> <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org> <41F9545A.4080803@kroon.co.za> <Pine.LNX.4.58.0501271314070.2362@ppc970.osdl.org> <41F96743.9060903@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F96743.9060903@kroon.co.za>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 12:12:19AM +0200, Jaco Kroon wrote:
 
> Yes.  You understand correctly.  Booting with acpi=off though has deadly 
> implications when rebooting though (bios gives you the black screen of 
> void).  So I would like to keep booting with acpi=off down to an 
> absolute minimum.

Did you ever try using "acpi=off" together with "i8042.nomux=1"? That
could help with the rebooting problem (iirc, you had a multiplexing
controller, didn't you?). Also, if you could try whether "usb-handoff"
instead of "acpi-off" has the same effect, like it has for Sebastian,
that'd be a good data point, too.

 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

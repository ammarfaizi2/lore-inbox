Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTLIRDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 12:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266070AbTLIRDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 12:03:08 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:18616 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S263771AbTLIRDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 12:03:06 -0500
Date: Tue, 9 Dec 2003 12:02:50 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031209170249.GB30286@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Joe Thornber <thornber@sistina.com>,
	Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20031209134551.GG472@reti> <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 12:10:06PM -0200, Marcelo Tosatti wrote:
> As far as I know, we already have the similar functionality in 2.4 with
> LVM. Device mapper provides the same functionality but in a much cleaner
> way. Is that right?

Yes.
 
And migration of root-on-LVM users to 2.6 will be *greatly* helped if users
can get LVM2/DM working on 2.4 (by upgrading lvm/initscripts/mkinitrd),
and then move to 2.6.

And LVM1 snapshots in 2.4 have limited value, due to the performance impact.

    Bill Rugolsky

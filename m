Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWAUXDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWAUXDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWAUXDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:03:06 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18594 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751219AbWAUXDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:03:04 -0500
Subject: Re: Development tree, PLEASE?
From: Lee Revell <rlrevell@joe-job.com>
To: Michael Loftis <mloftis@wgops.com>
Cc: Sven-Haegar Koch <haegar@sdinet.de>,
       Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <3B0BEE012630B9B11D1209E5@dhcp-2-206.wgops.com>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com>
	 <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>
	 <1137829140.3241.141.camel@mindpipe>
	 <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de>
	 <1137881882.411.23.camel@mindpipe>
	 <3B0BEE012630B9B11D1209E5@dhcp-2-206.wgops.com>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 18:03:01 -0500
Message-Id: <1137884582.411.47.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 15:40 -0700, Michael Loftis wrote:
> I don't feel that statement is true in all cases.  It's true in a lot
> of cases yes, but sometimes 'support' is really simply a matter of
> techinga module one more PCI ID.  Or adding in a few lines of code for
> a different PHY in the case of an ethernet adapter/MAC.  You also
> don't need to change say the queue elevator mechanism to support a new
> SATA chipset.  What the complaint is from production systems is the
> fact that in many many cases for new hardware support all that's
> needed is the little bit of code way out on the edge, without changing
> anything else.  

In order to "support" AMD X2 systems, it was necessary to revamp the
kernel's internal timekeeping.  How are we expected to deal with vendors
who break backwards compatibility on a deep level like this?

So basically a "stable kernel" means no new hardware support, which
basically means it's dead from the development POV - who would want to
work on such a thing?

Lee


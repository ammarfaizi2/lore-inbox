Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWAVJEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWAVJEN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 04:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWAVJEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 04:04:12 -0500
Received: from free.wgops.com ([69.51.116.66]:5129 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S932158AbWAVJEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 04:04:11 -0500
Date: Sun, 22 Jan 2006 02:03:49 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Sven-Haegar Koch <haegar@sdinet.de>,
       Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Development tree, PLEASE?
Message-ID: <F2CD9CC3F050829D8C8DC767@dhcp-2-206.wgops.com>
In-Reply-To: <1137884582.411.47.camel@mindpipe>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com>	
 <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>	
 <1137829140.3241.141.camel@mindpipe>	
 <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de>	
 <1137881882.411.23.camel@mindpipe>	
 <3B0BEE012630B9B11D1209E5@dhcp-2-206.wgops.com>
 <1137884582.411.47.camel@mindpipe>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 21, 2006 6:03:01 PM -0500 Lee Revell <rlrevell@joe-job.com> 
wrote:

> On Sat, 2006-01-21 at 15:40 -0700, Michael Loftis wrote:
>> I don't feel that statement is true in all cases.  It's true in a lot
>> of cases yes, but sometimes 'support' is really simply a matter of
>> techinga module one more PCI ID.  Or adding in a few lines of code for
>> a different PHY in the case of an ethernet adapter/MAC.  You also
>> don't need to change say the queue elevator mechanism to support a new
>> SATA chipset.  What the complaint is from production systems is the
>> fact that in many many cases for new hardware support all that's
>> needed is the little bit of code way out on the edge, without changing
>> anything else.
>
> In order to "support" AMD X2 systems, it was necessary to revamp the
> kernel's internal timekeeping.  How are we expected to deal with vendors
> who break backwards compatibility on a deep level like this?
>
> So basically a "stable kernel" means no new hardware support, which
> basically means it's dead from the development POV - who would want to
> work on such a thing?

That's why there's a maintenance/stable branch of most every single 
project, commercial or otherwise, and a development branch.  Development 
for new hardware continues, and for people who need these pieces of 
hardware which require major changes to work, then this much more limited 
set of users can take the rest of the issues that follow with using a dev 
kernel, until the stable branch moves up to/off/after the point at which 
the development branch got support for their new hardware.

A *lot* of us are using Linux for servers or other things that don't change 
every month.

And I'm not seeing/saying this sort of thing would stick forever, but a '6 
month cycle' or something of that nature.  Partly because of this I don't 
forsee myself having time to really start work on this for another month or 
two since I have to go into devel/bunker and get things working now at the 
demand of other entities than myself.

This thread has shown that there is desire for such a thing atleast by a 
few.  I'm just sure it's not a one man job, I've also been given a pointer 
that there is a stable team and I've yet to have time to go in that 
direction (really stirred the ants nest with this one).

>
> Lee
>
>



--
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler

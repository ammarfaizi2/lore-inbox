Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbUCISjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 13:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbUCISjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 13:39:43 -0500
Received: from mxsf04.cluster1.charter.net ([209.225.28.204]:45074 "EHLO
	mxsf04.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262081AbUCISjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 13:39:42 -0500
Date: Tue, 9 Mar 2004 13:38:57 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
Message-ID: <20040309183857.GB23839@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.GHP.4.44.0403082315490.3880-100000@elektron.its.tudelft.nl> <1078786761.9399.15.camel@athlonxp.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078786761.9399.15.camel@athlonxp.bradney.info>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.3-mm1 i686
X-Uptime: 13:22:22 up 18 days, 18:38,  7 users,  load average: 1.77, 1.18, 1.06
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Mon, Mar 08, 2004 at 11:59:21PM +0100, Craig Bradney wrote:
> 
> <snip>
> 
> I have put the idle=C1halt patch that Ross released a little while back
> now into Gentoo-dev-sources-2.6.3 as I reported to the list yesterday. I
> no longer use the old apic_tack=2 patch. I have been playing silly
> buggers with hardware, but so far the PC has made it to 11 hours and now
> 7 hours with no issues. 
> 

Just thought I would let everyone know that my A7N8X deluxe is up to:

 13:34:38 up 18 days, 18:50,  7 users,  load average: 1.00, 1.03, 1.02

with 2.6.3-mm1 and no other patches.  I did put Ross's latest
idle=C1halt patch in their but forgot to pass the command-line arg.  I
do have disconnect turned off here, with it on my speakers make a high
pitched buzzing noise.  Of course, acpi, apic, local apic etc is
turned on.  So does anyone have a sure fire way to hang this thing
yet?
  
-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin

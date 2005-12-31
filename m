Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVLaLGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVLaLGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVLaLGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:06:18 -0500
Received: from smtp-4.smtp.ucla.edu ([169.232.46.138]:3517 "EHLO
	smtp-4.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1751325AbVLaLGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:06:18 -0500
Date: Sat, 31 Dec 2005 03:06:16 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Willy Tarreau <willy@w.ods.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <20051231072528.GY15993@alpha.home.local>
Message-ID: <Pine.LNX.4.64.0512310239460.23044@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301955350.22622@potato.cts.ucla.edu>
 <20051231072528.GY15993@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005, Willy Tarreau wrote:
> On Fri, Dec 30, 2005 at 08:00:34PM -0800, Chris Stromsoe wrote:
>
>> I couldn't get the machine to come up with 2.4.32, 2.4.30, or 2.4.27. 
>> It was hanging and then throwing the SCSI errors below.  The machine 
>> did come up with a vanilla 2.6.14.4 and appears to be working fine. 
>> I'm going to leave it up over the weekend and see if it oopses.  If it 
>> would help, I can mail out the .config for the 2.4.32 and 2.6.14.4 
>> builds, or provide other information of interest.
>
> Please do post at least the 2.4.32 .config, I'll try to boot it on my 
> system right here. I find it amazing that it suddenly stopped working 
> with the same kernels as before.

Both configs are at <http://hashbrown.cts.ucla.edu/pub/oops-200512/>.

I have no idea why it wouldn't come up with nosmp on the command line 
(being supplied by lilo as append="nosmp").  I tried warm boot, cold boot, 
removing all power from the hardware.  I booted from a rescue cd that had 
2.6 on it and the machine came up right away.  I tried to go back to 2.4 
and it hung and then had SCSI errors again, so I installed 2.6.14.4 and 
left it running.  I can put a copy of the 2.4.32 kernel and modules up if 
that would help.


-Chris

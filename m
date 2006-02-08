Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbWBHGcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbWBHGcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWBHGcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:32:50 -0500
Received: from smtp-4.smtp.ucla.edu ([169.232.46.138]:35007 "EHLO
	smtp-4.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1030565AbWBHGct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:32:49 -0500
Date: Tue, 7 Feb 2006 22:32:45 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Willy TARREAU <willy@w.ods.org>
cc: Roberto Nibali <ratz@drugphish.ch>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <Pine.LNX.4.64.0601151452460.5053@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.64.0602072228500.3253@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch>
 <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch>
 <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu> <43C2E243.5000904@drugphish.ch>
 <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601151431250.5053@potato.cts.ucla.edu> <20060115224642.GA10069@w.ods.org>
 <Pine.LNX.4.64.0601151452460.5053@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2006, Chris Stromsoe wrote:
> On Sun, 15 Jan 2006, Willy TARREAU wrote:
>> 
>> Thanks for the precision. So logically we should expect it to break 
>> sooner or later ?
>
> It is the same .config as one that crashed before, except that it has 
> DEBUG_SLAB defined.  If it does not crash, then adding pci=noacpi to the 
> command fixes the problem for me.

For what it's worth, I'm fairly certain at this point that the problem was 
hardware related.  After a week of uptime with 2.6 we had another pmd 
error and oops.  We then replaced the system board and one of the CPUs and 
have not seen any problems since.


-Chris

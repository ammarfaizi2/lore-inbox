Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWAFWRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWAFWRD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWAFWRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:17:03 -0500
Received: from smtp-8.smtp.ucla.edu ([169.232.47.137]:16348 "EHLO
	smtp-8.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S932577AbWAFWRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:17:00 -0500
Date: Fri, 6 Jan 2006 14:16:57 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Willy Tarreau <willy@w.ods.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.64.0601061416010.24856@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
 <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local>
 <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org>
 <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Chris Stromsoe wrote:
> On Fri, 6 Jan 2006, Chris Stromsoe wrote:
>
>> After a little more than one day up with 2.4.32 SMP+ACP+aic7xxx, I got 
>> another bad pmd and an oops this morning at 4:23am.  I'm going to boot 
>> vanilla 2.4.32 with nosmp and acpi=off.
>
> booting with "nosmp acpi=off" did not help.  The box hung as before, at

One last datapoint; 2.6.14.4 boots fine with "nosmp acpi=off".


-Chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265935AbUAMXRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266269AbUAMXRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:17:53 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:11394 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S265935AbUAMXRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:17:49 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: ANother debugging Q
Date: Tue, 13 Jan 2004 18:17:44 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200401131243.27614.gene.heskett@verizon.net> <20040113175638.GG20763@actcom.co.il>
In-Reply-To: <20040113175638.GG20763@actcom.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401131817.44856.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.56.190] at Tue, 13 Jan 2004 17:17:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 12:56, Muli Ben-Yehuda wrote:
>On Tue, Jan 13, 2004 at 12:43:27PM -0500, Gene Heskett wrote:
>> Is there a way to make the app itself inherit the strace so that
>> its errors can be located/defined and fixed?
>
>Short answer: man strace.
>Long answer: strace -f (or -ff).
>
>Cheers,
>Muli

Unforch, that seems to shut down the opening of the error advisory 
window.  It just sits there showing a blank (data wise) screen. And 
extensive scrolling back thru about 5 megs of the output doesn't 
disclose a missing file that I can see.  How would I go about 
redirecting that output to grep, it seems to bypass an

 "strace -f ksysguard|grep open"

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.


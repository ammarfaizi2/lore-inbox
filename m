Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbVDBCce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVDBCce (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVDBCce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:32:34 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:57051 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S263015AbVDBCcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:32:17 -0500
Date: Fri, 01 Apr 2005 20:32:04 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AMD64 Machine hardlocks when using memset
In-reply-to: <3Oy8m-74-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <424E0424.7080308@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3NZDp-4yY-7@gated-at.bofh.it> <3OmgF-6HV-17@gated-at.bofh.it>
 <3OmgF-6HV-15@gated-at.bofh.it> <3Oy8m-74-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee wrote:
> On Thu, 2005-03-31 at 22:37 -0600, Robert Hancock wrote:
> 
>>This is getting pretty ridiculous.. I've tried memory timings down to 
>>the slowest possible, ran Memtest86 for 4 passes with no errors, and 
>>it's been stable in Windows for a few months now. Still something is 
>>blowing up in Linux with this test though..
> 
> 
> Have you run the same memset test under windows?
> 
> I've traced a lot of oddball problems down to bad or marginal power
> supplies.

I've now built a similar test program for Windows. I've let it run over 
2000 iterations of 512MB memsets with no problems. On Linux it usually 
blew up with under 200 iterations. It does run visibly slower than the 
Linux version though - this is after all 32 bit Windows and it was 
compiled with crufty old Visual C++ 6.0 so it is probably not that 
optimized for this CPU. I will see if I can get a more optimized build 
of this to try in Mingw32 or something.. after all if it's related to 
some instruction combination or something it may not show up in the 
build I have.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


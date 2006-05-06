Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWEFRkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWEFRkO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 13:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWEFRkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 13:40:14 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16222 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750745AbWEFRkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 13:40:12 -0400
Date: Sat, 06 May 2006 11:37:20 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Bugs aren't features: X86_FEATURE_FXSAVE_LEAK
In-reply-to: <69mqY-1Ci-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <445CDED0.4070402@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <69bvw-2zO-5@gated-at.bofh.it> <69d4M-4Yx-19@gated-at.bofh.it>
 <69mqY-1Ci-9@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:
> Andi Kleen <ak@suse.de> writes:
> 
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>
>>> The recent fix for the AMD FXSAVE information leak had a problematic
>>> side effect.  It introduced an entry in the x86 features vector which
>>> is a bug, not a feature.
>> It's a non issue because it affects all AMD CPUs (except K5/K6).
>> You'll never find a system where only some CPUs have this problem.
> 
> I have a dual CPU system (Tyan Tomcat 1564D) where only one CPU is
> reported to have the F00F bug (iirc).  So yes, there can be
> SMP-systems where the CPU's have different bugs.

Point being, not this bug..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


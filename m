Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVITXyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVITXyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVITXyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:54:05 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19321 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750727AbVITXyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:54:04 -0400
Date: Tue, 20 Sep 2005 17:53:58 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: help interpreting oom-killer output
In-reply-to: <4OY0C-5kE-59@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4330A116.1040107@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4OY0C-5kE-59@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:
> 
> I'm running a modified 2.6.10 on an x86 uniprocessor system.  I keep 
> having processes killed by the oom killer at the same place while 
> running LTP.  The system has gigs of memory, so I find this kind of odd.
> 
> Could someone help me interpret the oom-killer output?  The first log 
> looks like this.

Looks like you were running out of ZONE_NORMAL memory (below 896MB). 
There is lots of high memory available but the allocation could not be 
satisfied from there.

I would try a newer kernel..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


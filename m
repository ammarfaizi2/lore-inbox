Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265104AbUE2PqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265104AbUE2PqM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 11:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUE2PqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 11:46:12 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:40924 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265104AbUE2PqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 11:46:05 -0400
Message-ID: <40B8A161.5040306@kegel.com>
Date: Sat, 29 May 2004 07:42:41 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler version
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John B. wrote:
> Quote from Adrian Bunk <bunk@fs.tum.de>:
>> Whether support for gcc 2.95 should be dropped is a discussion for 2.7.
> 
> Is there any single 3.x.x version of GCC that's actively in use by a large
> number of core developers?  How do we make a sensible recommendation if not?

As an aside, it seems like gcc-3.3.3 is pretty good.
There are some known problems with it, but the number is small.
I haven't tried gcc-3.4.0 much yet, but I have seen a few kernel patches
to fix issues 3.4.0 found in the kernel source.

I agree 2.6 should continue to support and compile correctly under gcc-2.95.3,
even if that means working around compiler bugs.  By the time linux-2.7
rolls around, I suspect nobody will mind if we drop 2.95.3 in favor
of 3.4.x.  It'll be interesting to see if newer gccs optimize the kernel better...
- Dan


-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change

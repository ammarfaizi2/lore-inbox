Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUJWKHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUJWKHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUJWKEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:04:54 -0400
Received: from dialup-4.246.12.161.Dial1.SanJose1.Level3.net ([4.246.12.161]:22144
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S266611AbUJWKEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:04:39 -0400
Message-ID: <417A2CBF.9060805@syphir.sytes.net>
Date: Sat, 23 Oct 2004 03:04:47 -0700
From: "C.Y.M" <syphir@syphir.sytes.net>
Reply-To: syphir@syphir.sytes.net
Organization: CooLNeT
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unknown symbol kill_proc_info in 2.6.10-rc1
References: <417A2292.9090008@syphir.sytes.net> <20041023095714.GD30137@infradead.org>
In-Reply-To: <20041023095714.GD30137@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Oct 23, 2004 at 02:21:22AM -0700, C.Y.M wrote:
> 
>>After building 2.6.10-rc1, i was unable to load my "lufs" module due to 
>>an unknown symbol error (kill_proc_info).  When I examined the 
>>2.6.10-rc1 patch, I noticed that "EXPORT_SYMBOL(kill_proc_info);" was 
>>removed from signal.c.  With the following patch, I was able to resolve 
>>my problem, but I am not sure if this is the correct method.  Is there a 
>>reason why the kill_proc_info symbol is no longer exported?
> 
> 
> Because it's not an API you should be using.
> 
> 
Is there an alternative?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbTIKHE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 03:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbTIKHE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 03:04:56 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:23674 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266197AbTIKHEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 03:04:54 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Local DoS on single_open? 
In-reply-to: Your message of "Thu, 11 Sep 2003 14:51:09 +1000."
             <3F5FFF3D.9040707@cyberone.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Sep 2003 17:04:48 +1000
Message-ID: <5196.1063263888@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 14:51:09 +1000, 
Nick Piggin <piggin@cyberone.com.au> wrote:
>Keith Owens wrote:
>
>>single_open() requires the kernel to kmalloc a buffer which lives until
>>the userspace caller closes the file.  What prevents a malicious user
>>opening the same /proc entry multiple times, allocating lots of kmalloc
>>space and causing a local DoS?
>>  
>>
>
>ulimit?

ulimit has no effect on kmalloc usage.


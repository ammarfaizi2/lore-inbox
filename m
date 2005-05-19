Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVESAOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVESAOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 20:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVESAOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 20:14:55 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:20210 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262421AbVESAOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 20:14:53 -0400
Date: Wed, 18 May 2005 18:14:14 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: GDB, pthreads, and kernel threads
In-reply-to: <45zKO-3RV-45@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <428BDA56.5030502@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <45k9a-7DD-11@gated-at.bofh.it> <45xIX-2bR-31@gated-at.bofh.it>
 <45zKO-3RV-45@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Clark wrote:
> I built the latest GDB-6.3, as well as rebuilt glibc-2.3.5, and now when 
> I step through the
> main code line, which creates the tasks (I'm using the pthreads.c from 
> the GDB testsuite), I do
> not getany output from:
> 
> info threads
> 
> When I set a break point on the entry point of one of the 
> soon-to-be-created threads,
> I get a diagnostic message:
> 
> Program terminated with signal SIGTRAP, Trace/Breakpoint trap.
> The program no longer exists.

Are you sure your glibc and gdb were both configured to support threads 
when they were compiled?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


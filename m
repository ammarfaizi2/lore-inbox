Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUACTyH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUACTyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:54:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41746 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263760AbUACTyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:54:02 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0 performance problems
Date: Sat, 03 Jan 2004 14:54:10 -0500
Organization: TMR Associates, Inc
Message-ID: <bt75uc$cr2$1@gatekeeper.tmr.com>
References: <87brpq7ct3.wl@canopus.ns.zel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073158924 13154 192.168.12.10 (3 Jan 2004 19:42:04 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <87brpq7ct3.wl@canopus.ns.zel.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff wrote:
> Reality sucks.
> 
> People are ignorant enough to turn blind eye to obvious vm regressions.
> 
> No developers run 64M boxens anymore...

Developers shound NOT be running slow machines, but they should be 
testing slow machines. I do my builds on a four way Xeon machine, and 
install on a slow machine for test.

If you look at some of the response testing I'm doing, it's one a 96MB 
p3-350, just for that reason. And I have a P5-133 I built but haven't 
really benchmarked yet, it has only 64MB. I think the place such slow 
machines are relevant is embedded, which is why I occasionally rant 
about locking in code to hide Athlon CPU bugs which just wastes space on 
unbroken machines.

I have a pile of 486 machines I want to run as firewalls, don't plan to 
do kernel builds on those, either :-(

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979

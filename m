Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUABU1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbUABU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:27:37 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28688 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265663AbUABU1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:27:31 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Fri, 02 Jan 2004 15:10:52 -0500
Organization: TMR Associates, Inc
Message-ID: <bt4jh7$6i2$2@gatekeeper.tmr.com>
References: <200312231138.21734.kernel@kolivas.org> <3FE79626.1060105@cyberone.com.au> <200312231224.49069.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073074535 6722 192.168.12.10 (2 Jan 2004 20:15:35 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <200312231224.49069.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> I discussed this with Ingo and that's the sort of thing we thought of. Perhaps 
> a relative crossover of 10 dynamic priorities and an absolute crossover of 5 
> static priorities before things got queued together. This is really only 
> required for the UP HT case.

What? Do siblings in Xeons not compete for cache and memory bandwidth, 
executions units, and the like?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979

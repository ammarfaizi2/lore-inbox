Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWCQSUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWCQSUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWCQSUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:20:41 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:29860 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030254AbWCQSUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:20:40 -0500
Message-ID: <441AFD8A.5050003@cfl.rr.com>
Date: Fri, 17 Mar 2006 13:18:50 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: chmod 111
References: <200603171746.18894.nick@linicks.net>
In-Reply-To: <200603171746.18894.nick@linicks.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2006 18:23:04.0573 (UTC) FILETIME=[D4F8E2D0:01C649EF]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14329.000
X-TM-AS-Result: No--1.500000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> 76 ---x--x--x  1 root bin 72608 2004-03-16 02:08 ls
> 
> I shouldn't be able to execute 'ls' as I can't read it, shouldn't it?


Of course you can execute it because you have execute permission.  Lack 
of read permission just prevents you from read()ing the file.


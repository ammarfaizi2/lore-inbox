Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWEIAIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWEIAIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 20:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWEIAIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 20:08:12 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:51383 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750918AbWEIAIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 20:08:10 -0400
Message-ID: <445FDD68.20703@bigpond.net.au>
Date: Tue, 09 May 2006 10:08:08 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <E1FdE9I-00058a-00@calista.inka.de>
In-Reply-To: <E1FdE9I-00058a-00@calista.inka.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 9 May 2006 00:08:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> Erik Mouw <erik@harddisk-recovery.com> wrote:
>> ... except that any kernel < 2.6 didn't account tasks waiting for disk
>> IO. Load average has always been somewhat related to tasks contending
>> for CPU power.
> 
> Actually all Linux kernels accounted for diskwaits and others like BSD based
> not. It is a very old linux oddness.

Personally, I see both types of load estimates (i.e. CPU only and CPU 
plus IO wait) as useful.  Why can't we have both?  The cost would be 
minimal.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

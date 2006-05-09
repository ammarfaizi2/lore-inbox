Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWELOEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWELOEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWELOEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:04:13 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:54867 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932083AbWELOEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:04:13 -0400
Message-ID: <4460E06D.5010903@tmr.com>
Date: Tue, 09 May 2006 14:33:17 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Bernd Eckenfels <be-news06@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <20060508152255.GF1875@harddisk-recovery.com> <E1FdE9I-00058a-00@calista.inka.de>
In-Reply-To: <E1FdE9I-00058a-00@calista.inka.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Well, sort of. The current numbers are counting kernel threads against 
load average, and before there were kernel threads that clearly didn't 
happen. So what you say is true, but it's only a part of the truth.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


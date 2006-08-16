Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWHPIDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWHPIDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWHPIDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:03:36 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:3728 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750748AbWHPIDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:03:35 -0400
Message-ID: <44E2D196.7000102@sw.ru>
Date: Wed, 16 Aug 2006 12:04:38 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, containers@lists.osdl.org,
       linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Containers] [PATCH 1/7] pid: Implement access helpers for a
 tacks various	process groups.
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>	<11556661922952-git-send-email-ebiederm@xmission.com> <1155667238.12700.58.camel@localhost.localdomain>
In-Reply-To: <1155667238.12700.58.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2006-08-15 at 12:23 -0600, Eric W. Biederman wrote:
> 
>>+static inline struct pid *task_pid(struct task_struct *task)
>>+{
>>+       return task->pids[PIDTYPE_PID].pid;
>>+} 
> 
> 
> Does this mean we can start to deprecate the use of tsk->pid?
Thats the final goal imho :)))

Kirill

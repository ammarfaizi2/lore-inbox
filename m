Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWHOSlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWHOSlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWHOSlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:41:00 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6119 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965060AbWHOSk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:40:59 -0400
Subject: Re: [PATCH 1/7] pid: Implement access helpers for a tacks various
	process groups.
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <11556661922952-git-send-email-ebiederm@xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	 <11556661922952-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 11:40:38 -0700
Message-Id: <1155667238.12700.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 12:23 -0600, Eric W. Biederman wrote:
> +static inline struct pid *task_pid(struct task_struct *task)
> +{
> +       return task->pids[PIDTYPE_PID].pid;
> +} 

Does this mean we can start to deprecate the use of tsk->pid?

-- Dave


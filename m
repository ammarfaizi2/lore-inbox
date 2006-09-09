Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWIICj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWIICj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 22:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWIICj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 22:39:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26509 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751000AbWIICj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 22:39:57 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, containers@lists.osdl.org
Subject: Re: [patch -mm] update mq_notify to use a struct pid
References: <45019CC3.2030709@fr.ibm.com>
Date: Fri, 08 Sep 2006 20:39:05 -0600
In-Reply-To: <45019CC3.2030709@fr.ibm.com> (Cedric Le Goater's message of
	"Fri, 08 Sep 2006 18:39:31 +0200")
Message-ID: <m18xktkbli.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> message queues can signal a process waiting for a message.
>
> this patch replaces the pid_t value with a struct pid to avoid pid wrap
> around problems.
>
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@osdl.org>
> Cc: containers@lists.osdl.org

Signed-off-by: Eric Biederman <ebiederm@xmission.com>

I was just about to send out this patch in a couple more hours.
So expect the fact we wrote the same code is a good sign :)


Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWIFUvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWIFUvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWIFUvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:51:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48566 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751252AbWIFUvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:51:16 -0400
Date: Wed, 6 Sep 2006 13:51:13 -0700
From: Paul Jackson <pj@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-Id: <20060906135113.00051e89.pj@sgi.com>
In-Reply-To: <20060906182719.GB24670@sergelap.austin.ibm.com>
References: <20060906182719.GB24670@sergelap.austin.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge wrote:
> 	One remaining question is the note under task_setscheduler: are we
> 	ok with CAP_SYS_NICE being sufficient to confine a process to a
> 	cpuset?

So far as I know (which isn't very far ;), that's ok.

Can you explain to me how this will visibly affect users?

Under what conditions, with what kernel configurations or options
selected or not, and with what permissions settings, would they notice
any difference, before and after this patch, in the behaviour of
cpusets, such as when they do the operation of writing a pid to tasks
file that invokes kernel/cpuset.c:attach_task()?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

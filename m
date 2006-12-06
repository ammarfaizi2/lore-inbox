Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937687AbWLFVm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937687AbWLFVm5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937683AbWLFVm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:42:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58082 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937679AbWLFVmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:42:55 -0500
Message-ID: <45773883.5040003@redhat.com>
Date: Wed, 06 Dec 2006 16:39:15 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: eranian@hpl.hp.com, perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       oprofile-list@lists.sourceforge.net,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [perfmon] 2.6.19 new perfmon code base + libpfm + pfmon
References: <20061204164644.GO31914@frankl.hpl.hp.com> <4575AB54.2050509@redhat.com> <20061205222810.GA6385@infradead.org>
In-Reply-To: <20061205222810.GA6385@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Dec 05, 2006 at 12:24:36PM -0500, William Cohen wrote:
> 
>>Some of the ptrace functions (e.g. ptrace_may_attach in perfmon_syscall.c) 
>>being used in the perfmon kernel patches will go away with the utrace 
>>patches: http://people.redhat.com/roland/utrace/
> 
> 
> At least for ptrace_may_attach that's not true in the lastest version
> from Roland - in fact it's the last unconditional function in ptrace.c
> in that version.  I suggested to him to rename and move it in my review,
> though.
> 

Sorry. I meant the function ptrace_check_attach(). -Will

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVEBJKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVEBJKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 05:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVEBJKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 05:10:44 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:10417 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261155AbVEBJKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 05:10:39 -0400
Message-ID: <4275EE8B.5030201@yahoo.com.au>
Date: Mon, 02 May 2005 19:10:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: dino@in.ibm.com
CC: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
References: <20050501190947.GA5204@in.ibm.com>
In-Reply-To: <20050501190947.GA5204@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:
> Ok, Here is the minimal patchset that I had promised after the
> last discussion.
> 

The sched-domains part of it (kernel/sched.c) is looking much
better now. Haven't had a really good look, but it is definitely
on the right track now. Well done.

As I said before, I am not expert on the cpusets side of things,
but as far as sched-domains partitioning goes, we really just
want the absolute minimum support in kernel/sched.c which can be
managed by a higher layer.

I'll review it in detail when it gets into -mm, but I don't expect
to find any major problems.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


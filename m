Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWCSPHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWCSPHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWCSPHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:07:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60312 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751504AbWCSPHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:07:38 -0500
To: Paul Jackson <pj@sgi.com>
Cc: ebiederm@xmission.com (Eric W. Biederman), akpm@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cpuset: remove unnecessary NULL check
References: <20060319085743.18841.45970.sendpatchset@jackhammer.engr.sgi.com>
	<m1acbmzfw5.fsf@ebiederm.dsl.xmission.com>
	<20060319065614.371823f2.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 19 Mar 2006 08:06:10 -0700
In-Reply-To: <20060319065614.371823f2.pj@sgi.com> (Paul Jackson's message of
 "Sun, 19 Mar 2006 06:56:14 -0800")
Message-ID: <m1y7z6xyn1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> Eric wrote:
>> Comments that refer to a nebulous hack ...
>
> Well, in this case, it wasn't so nebulous, to me anyway.

Right.  The core problem was there was not enough context to see
what the dependency was from the comment.  

>
> The "Hack" referred to has a big fat comment beginning:
>
>  *
>  * Hack:
>  *
>  *    Set the exiting tasks cpuset to the root cpuset (top_cpuset).
>  *
>  *    Don't leave a task unable to allocate memory, as ...
>
> and is labeled at the scene of the Hack with:
>
>         tsk->cpuset = &top_cpuset;      /* Hack - see comment above */
>
> So "Hack" was intended as a proper noun, not a nebulous generic term.
>
> But, sure, hard to argue with anyone wanting improved comments.
>
> And while I'm at it, I will change the name of this Hack to something
> less generic ... say "the_top_cpuset_hack".
>
> Patch coming soon.

Thanks.

Eric

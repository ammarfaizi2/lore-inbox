Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751988AbWCNTTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbWCNTTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 14:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbWCNTTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 14:19:10 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:15322 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751988AbWCNTTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 14:19:09 -0500
Subject: Re: question: pid space semantics.
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>,
       "Dave Hansen <haveblue@us.ibm.com> Cedric Le Goater" <clg@fr.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org
In-Reply-To: <m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
References: <1142282940.27590.17.camel@localhost.localdomain>
	 <m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 11:18:16 -0800
Message-Id: <1142363896.28604.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 11:43 -0700, Eric W. Biederman wrote:
> The question:
>   If we could add additional pid values in different pid spaces to a
>   process with a syscall upon demand would that lead to an
>   implementation everyone could use? 

So, you'd basically only allocate the cross-namespace pids when you
needed to do some kind of cross-namespace management?

pid_t alloc_local_pid(container_handle, pid_t pid_inside_container)

-- Dave


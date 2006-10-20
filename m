Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992557AbWJTHfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992557AbWJTHfv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992566AbWJTHfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:35:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992557AbWJTHfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:35:50 -0400
Date: Fri, 20 Oct 2006 00:35:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       Cal Peake <cp@absolutedigital.net>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
Message-Id: <20061020003540.10d367d9.akpm@osdl.org>
In-Reply-To: <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
	<Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
	<20061018124415.e45ece22.akpm@osdl.org>
	<m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
	<m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 01:05:18 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> Anyone who is interested in knowing if they have an application on
> their system that actually uses sys_sysctl please run the following grep.
> 
> find / -type f  -perm /111 -exec fgrep 'sysctl@@GLIBC' '{}' ';' 
> 
> The -perm /111 is an optimization to only look at executable files,
> and may be omitted if you are patient.
> 
> Currently I don't expect anyone to find a match anywhere except in libpthreads,
> if you find any others please let me know.
> 

http://www.google.com/codesearch

there are a few hits...

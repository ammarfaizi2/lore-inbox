Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbUKNAfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUKNAfp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 19:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUKNAfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 19:35:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:23273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261221AbUKNAfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 19:35:12 -0500
Message-ID: <4196A7E0.4040107@osdl.org>
Date: Sat, 13 Nov 2004 16:33:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: System call number
References: <41969845.1060803@euroweb.net.mt> <yw1x6549jo6v.fsf@ford.inprovide.com>
In-Reply-To: <yw1x6549jo6v.fsf@ford.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> "Josef E. Galea" <josefeg@euroweb.net.mt> writes:
> 
> 
>>Hi,
>>
>>Can anyone tell me the system call number for the function
>>write_swap_page() (in kernel/power/pmdisk.c) as I can't find it in
>>unistd.h.
> 
> 
> What makes you believe that function is a system call in the first
> place?  It doesn't look like one to me.  Hint: system calls have names
> prefixed with sys_ (are there any exceptions?).

Not that I know of.  I changed a few syscall names roughly 1 year
ago so that they begin with sys_xyz (and some that began with
sys_xyz that were not syscalls, I changed those also. :)


-- 
~Randy

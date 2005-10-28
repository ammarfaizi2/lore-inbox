Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVJ1QyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVJ1QyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVJ1QyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:54:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18594 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030254AbVJ1QyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:54:02 -0400
To: Vladimir Lazarenko <vlad@lazarenko.net>
Cc: thockin@hockin.org, linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon64 X2 Dual-core and 4GB
References: <4361408B.60903@lazarenko.net>
	<m1irvhbqvo.fsf@ebiederm.dsl.xmission.com>
	<20051028160403.GA26286@hockin.org> <43625484.30100@lazarenko.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 28 Oct 2005 10:52:32 -0600
In-Reply-To: <43625484.30100@lazarenko.net> (Vladimir Lazarenko's message of
 "Fri, 28 Oct 2005 18:40:36 +0200")
Message-ID: <m11x25bn3j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Lazarenko <vlad@lazarenko.net> writes:

>>>>Thus, the question - would I be able to use whole 4G RAM with dual-core amd
> and
>>>>kernel with SMP compiled for i686?
>> Why would you use a dual core AMD in 32 bit mode?  Just build an x86_64
>> kernel.
>> If you want to use 4GB in 32 bit mode, you *need* remapping (or you lose
>> part of your memory).  Remapping means you have MORE than 4 GB of physical
>> address, which means you need PAE to use it at all.
>
> Because I find my distribution's 64-bit release reasonably unstable yet? :)
>
> Or can I somehow build an x86_64 kernel and keep using 32-bit libc?

Building a x86_64 kernel is a bit of a trick on a 32bit distro.  
You need an appropriate version of gcc, and binutils.  But it runs
fine.

Eric

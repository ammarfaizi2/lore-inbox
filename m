Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVJ1QPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVJ1QPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbVJ1QPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:15:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56481 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030221AbVJ1QPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:15:19 -0400
To: thockin@hockin.org
Cc: Vladimir Lazarenko <vlad@lazarenko.net>, linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon64 X2 Dual-core and 4GB
References: <4361408B.60903@lazarenko.net>
	<m1irvhbqvo.fsf@ebiederm.dsl.xmission.com>
	<20051028160403.GA26286@hockin.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 28 Oct 2005 10:13:46 -0600
In-Reply-To: <20051028160403.GA26286@hockin.org> (thockin@hockin.org's
 message of "Fri, 28 Oct 2005 09:04:03 -0700")
Message-ID: <m1acgtbow5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thockin@hockin.org writes:

> On Fri, Oct 28, 2005 at 09:30:51AM -0600, Eric W. Biederman wrote:
>> > Thus, the question - would I be able to use whole 4G RAM with dual-core amd
> and
>> > kernel with SMP compiled for i686?
>
> Why would you use a dual core AMD in 32 bit mode?  Just build an x86_64
> kernel.
>
> If you want to use 4GB in 32 bit mode, you *need* remapping (or you lose
> part of your memory).  Remapping means you have MORE than 4 GB of physical
> address, which means you need PAE to use it at all.

Yes, and PAE works fine with a 32bit kernel.  I agree it is a silly
configuration and a 64bit kernel would use the memory more
efficiently.  My basic point was that a dual-core is a recent enough
processor from AMD that it supports memory remapping.  So with a
correct BIOS there should be no problems. 

Eric


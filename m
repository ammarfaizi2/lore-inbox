Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWA3AnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWA3AnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 19:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWA3AnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 19:43:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49897 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751213AbWA3AnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 19:43:01 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
References: <20060129144533.128af741.akpm@osdl.org>
	<20060129233403.GA3777@stusta.de>
	<20060129162524.4b84a56c.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 17:42:11 -0700
In-Reply-To: <20060129162524.4b84a56c.akpm@osdl.org> (Andrew Morton's
 message of "Sun, 29 Jan 2006 16:25:24 -0800")
Message-ID: <m1bqxu7di4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Adrian Bunk <bunk@stusta.de> wrote:
>>
>> n Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
>>  >...
>>  > Changes since 2.6.16-rc1-mm3:
>>  >...
>>  > +i386-add-a-temporary-to-make-put_user-more-type-safe.patch
>>  > 
>>  >  x86 fixes/features
>>  >...
>> 
>>  This patch generates so many "ISO C90 forbids mixed declarations and code"
>>  warnings that I start to consider Andrew's rejection of my "mark 
>>  virt_to_bus/bus_to_virt as __deprecated on i386" patch due to the 
>>  warnings it generates a personal insult...
>
> Bah, that's what you get for using a slow compiler.

Doh.  I thought __chk_user_ptr(ptr) was some kind of sparse annotation
and not code.

Thanks for catching this.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWARFYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWARFYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWARFYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:24:53 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:9358 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030253AbWARFYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:24:52 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mita@miraclelinux.com
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces 
In-reply-to: Your message of "Tue, 17 Jan 2006 18:12:20 BST."
             <Pine.LNX.4.61.0601171811530.18569@yvahk01.tjqt.qr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Jan 2006 16:23:37 +1100
Message-ID: <9836.1137561817@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt (on Tue, 17 Jan 2006 18:12:20 +0100 (MET)) wrote:
>> > Presumably this is going to bust ksymoops.
>> 
>>Do people actually still use ksymoops for 2.6 kernels ?
>
>I think it was said often enough that people _should not_ use it for 2.6. 
>Unfortunately, there are still some who do.

Some people use ksymoops because the kernel oops does not decode the
instructions.  Some people use ksymoops because they run embedded
systems and cannot afford the kallsyms data.  Others just use ksymoops
out of habit.


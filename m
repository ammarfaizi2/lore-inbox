Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUGFM2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUGFM2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 08:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUGFM2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 08:28:32 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:30660 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S263802AbUGFM2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 08:28:31 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Joseph Fannin <jhf@rivenstone.net>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org
Subject: Re: 2.6.7-mm6 - ppc32 inconsistent kallsyms data 
In-reply-to: Your message of "Tue, 06 Jul 2004 19:09:23 +1000."
             <1089104963.9417.4.camel@bach> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Jul 2004 22:28:22 +1000
Message-ID: <2816.1089116902@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jul 2004 19:09:23 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>On Tue, 2004-07-06 at 17:31, Keith Owens wrote:
>> This is a real linker problem on ppc32.  The linker automatically adds
>> _SDA_BASE_ and _SDA2_BASE_ symbols, these symbols are not defined in
>> vmlinux.lds.S.
>
>What type are those symbols?  I'm surprised they're not 'A' which is
>already ignored...

'D'


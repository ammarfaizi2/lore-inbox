Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264968AbUFAJzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbUFAJzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264970AbUFAJzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:55:35 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:33219 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S264968AbUFAJza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:55:30 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.7-rc2] Add const to some scheduling functions 
In-reply-to: Your message of "Tue, 01 Jun 2004 00:16:32 MST."
             <20040601001632.1cc185ba.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Jun 2004 19:55:24 +1000
Message-ID: <12672.1086083724@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004 00:16:32 -0700, 
Andrew Morton <akpm@osdl.org> wrote:
>Keith Owens <kaos@ocs.com.au> wrote:
>>
>> Several scheduler macros only read from the task struct, mark them
>>  const.  It can generate better code.
>
>It makes no change to the gcc-3.4.0-compiled x86 kernel's size.  Under what
>circumstances did you see improvements?

None, it is just good programming practice to mark parameters as const
where possible.


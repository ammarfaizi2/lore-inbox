Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWAYLKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWAYLKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 06:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWAYLKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 06:10:46 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:22468 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751115AbWAYLKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 06:10:46 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: eranian@hpl.hp.com
cc: "Bryan O'Sullivan" <bos@serpentine.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] 2.6.16-rc1 perfmon2 patch for review 
In-reply-to: Your message of "Tue, 24 Jan 2006 07:13:25 -0800."
             <20060124151325.GC7130@frankl.hpl.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 25 Jan 2006 22:10:44 +1100
Message-ID: <23407.1138187444@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian (on Tue, 24 Jan 2006 07:13:25 -0800) wrote:
>Well, I am not sure why the smp_call_function_single() is not already
>implemented for i386. I can see that the underlying function send_IPI_mask()
>is there. It also looks like flush_tlb_others() is also selecting CPUs a subset
>of CPUs. I am not a big enough expert on x86 to understand if there are gotchas
>to watch for. Yet it would surprise me if this is radically different than on
>x86_64 (em64t) which already has the call. Maybe someone can clarify this?

There is no hardware reason why smp_call_function_single() cannot be
implemented on i386.  The only reason it has not been implemented on
i386 is that nobody has had a need for it yet.


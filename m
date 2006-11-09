Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161769AbWKIFaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161769AbWKIFaO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 00:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161739AbWKIFaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 00:30:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10374 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161769AbWKIFaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 00:30:12 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH] IB/ipath - program intconfig register using new HT irq hook
References: <545156d49f883c43af70.1163024486@localhost.localdomain>
	<20061108144402.0b6a7b23.akpm@osdl.org>
	<4552636E.3090809@pathscale.com>
	<20061108151821.5a55fecd.akpm@osdl.org>
Date: Wed, 08 Nov 2006 22:29:14 -0700
In-Reply-To: <20061108151821.5a55fecd.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 8 Nov 2006 15:18:21 -0800")
Message-ID: <m1mz71193p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 08 Nov 2006 15:08:30 -0800
> "Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
>> Andrew Morton wrote:
>
>> > considered 2.6.19 material?
>> 
>> Yes, please.  I might be able to simplify the ib-ipath patch (by a 
>> matter of a few lines), but it works fine as it stands.
>> 
>
> ho hum, OK.

There is only one driver in the kernel that currently uses the htirq
the infrastructure so the chance of actually breaking something else 
is exactly 0. :)

Thanks for collecting the patches up Andrew.

I know of a couple out of tree drivers but I don't think their
hardware has escaped the lab yet.

Eric

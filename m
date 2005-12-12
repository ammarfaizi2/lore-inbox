Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVLLNoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVLLNoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 08:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVLLNoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 08:44:30 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:59113 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751198AbVLLNo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 08:44:29 -0500
Date: Mon, 12 Dec 2005 16:44:27 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rth@twiddle.net, davej@redhat.com, zwane@arm.linux.org.uk, ak@suse.de,
       ashok.raj@intel.com
Subject: Re: [PATCH] alpha build pm_power_off hack
Message-ID: <20051212164427.A18478@jurassic.park.msu.ru>
References: <20051211232428.18286.40968.sendpatchset@sam.engr.sgi.com> <m1y82qany7.fsf@ebiederm.dsl.xmission.com> <20051211222404.d35f990c.pj@sgi.com> <m1u0dea539.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1u0dea539.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Mon, Dec 12, 2005 at 05:10:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 05:10:34AM -0700, Eric W. Biederman wrote:
> +/*
> + * Power off function, alpha doesn't use but we should
> + * always call machine_power_off.
> + */
> +void (*pm_power_off)(void) = machine_power_off;
> +

This one makes sense, thanks.

Ivan.

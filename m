Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVKUWGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVKUWGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVKUWGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:06:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:62174 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751118AbVKUWGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:06:09 -0500
Date: Mon, 21 Nov 2005 23:06:05 +0100
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       linuxbios@openbios.org
Subject: Re: x86_64: apic id lift patch
Message-ID: <20051121220605.GD20775@brahms.suse.de>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 01:49:09PM -0800, yhlu wrote:
> Andi,
> 
> Please check the patch regarding apicid lifting.
> 
> For some reason, we need to lift AP apicid but keep the BSP apicid to 0....
> 
> Also it solve the E0 later single but have apic id reorder problem...

Can you please explain clearly:

- What are you changing.
- What was the problem with the old behaviour
- Why that particular change
- Why can't that APIC number setup not be done by the BIOS itself

Thanks.

Please note there is a high barrier of entry for any kind of BIOS workarounds -
in particular for LinuxBIOS i'm not very motivated because you guys can
just fix the BIOS.

-Andi


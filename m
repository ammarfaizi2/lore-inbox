Return-Path: <linux-kernel-owner+w=401wt.eu-S1752964AbWL1Oi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbWL1Oi7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 09:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbWL1Oi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 09:38:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:9844 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbWL1Oi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 09:38:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rnutvtlCyFJhbvHYaGvKrJkX7casbI/exgaonIKetFsvb6ngIxDKnFzn/h6qZRFwOjc6QYf72O9F0pjPV3pXVR5qkPtPLOxtw7P2AReIWV8Uhv9l+5iIQe5Xnk4K3iIvCsov4bv6s836xgBy0azd9T8BhU0zt1zRauxlurfcxRM=
Message-ID: <b6a2187b0612280638o3d7c48ecn13b5dece8395b41a@mail.gmail.com>
Date: Thu, 28 Dec 2006 22:38:52 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Dor Laor" <dor.laor@qumranet.com>
Subject: Re: open /dev/kvm: No such file or directory
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <64F9B87B6B770947A9F8391472E0321609AB0D35@ehost011-8.exch011.intermedia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com>
	 <64F9B87B6B770947A9F8391472E0321609AB0D35@ehost011-8.exch011.intermedia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/06, Dor Laor <dor.laor@qumranet.com> wrote:
> Are you sure the kvm_intel & kvm modules are loaded?

Yes.

> Maybe you're bios does not support virtualization.

Configured in the bios on Dell 745.

> Please check your dmesg.

I'll double-check dmesg when I get to the office tomorrow. But I'm
pretty sure it's loaded successfully on the Dell Optiplex 745. On my
IBM X60s notebook, it failed to load.


> It's a dynamic misc device, you don't need to create it.

But it'll be nice to be able to manually create the device as I
normally mount "/" as read-only?


Thanks,
Jeff.

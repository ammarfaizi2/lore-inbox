Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTIKQUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbTIKQUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:20:41 -0400
Received: from ns.suse.de ([195.135.220.2]:30411 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261352AbTIKQUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:20:37 -0400
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	<20030911161450.GA23536@sgi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Sep 2003 18:20:08 +0200
In-Reply-To: <20030911161450.GA23536@sgi.com.suse.lists.linux.kernel>
Message-ID: <p73k78fi9fr.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) writes:
> 
> I like this idea, esp. as a global option.  It would help e.g. visws
> which can't reliably do MMIO.  Most platforms could default MMIO to y
> also, to make things easier.

The problem AFAIK is usually that there are some buggy older chipset
versions that do not work properly with MMIO, but others do.
That's especially an issue on widely cloned cards like Tulip.

It's not a platform specific thing, more a device specific setting.
Of course some platforms want to disable it completely too, but that's
rare.

-Andi

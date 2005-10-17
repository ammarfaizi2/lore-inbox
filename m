Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVJQTHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVJQTHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVJQTHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:07:13 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:36538 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932267AbVJQTHL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:07:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i9WEQezEmQm1D6cQ7aNE6RMOFe2CSbkG8IX8U0kx4CtxAaagVNtdI7nV1PPSKwnux+qfCEPs9JduSJbLhgjCg4huhBEVBofNweQNULRfWcMGOgoq1PypEf3hji/SI1UvYe+7/kGrE/NVyPBxhJ08a1K0RQdBC3Vcef/RmryGpLQ=
Message-ID: <12c511ca0510171207v28030070p40a0ec769a93a101@mail.gmail.com>
Date: Mon, 17 Oct 2005 12:07:10 -0700
From: Tony Luck <tony.luck@intel.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       tglx@linutronix.de, torvalds@osdl.org, shai@scalex86.org,
       "John W. Linville" <linville@tuxdriver.com>
In-Reply-To: <20051017100257.GD21783@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017093654.GA7652@localhost.localdomain>
	 <20051017025007.35ae8d0e.akpm@osdl.org>
	 <20051017100257.GD21783@granada.merseine.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> x86-64 uses swioltb as well, via arch/ia64 directly. John Linville has
> a patch to move the swiotlb to lib/swiotlb.c that is waiting in an
> IA64 for inclusion (post 2.6.14, I guess?)

Yes.  John's patch is sitting in a "swiotlb" branch of my GIT tree.  I'd like to
hear some positive confirmation from Linus and/or Andrew that moving this
up to lib/ is ok ... I don't want to be accused of shovelling tasteless code up
into the base.

This is definitely a post 2.6.14 move.

-Tony

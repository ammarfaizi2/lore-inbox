Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWEARef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWEARef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWEARef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:34:35 -0400
Received: from mx.pathscale.com ([64.160.42.68]:60560 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932171AbWEARef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:34:35 -0400
Subject: Re: [PATCH 8 of 13] ipath - fix a number of RC protocol bugs
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <adar73dwtga.fsf@cisco.com>
References: <patchbomb.1145913776@eng-12.pathscale.com>
	 <fafcc38877ad194f3a7a.1145913784@eng-12.pathscale.com>
	 <20060425005654.4c08481f.akpm@osdl.org>  <adar73dwtga.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 10:34:34 -0700
Message-Id: <1146504874.2906.7.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 10:22 -0700, Roland Dreier wrote:
>     Andrew> Please don't play around with list_head internals like
>     Andrew> this - some speedfreak might legitimately choose to remove
>     Andrew> the list_head poisoning debug code, or make it
>     Andrew> Kconfigurable.
> 
> Bryan, can you fix this up and resend this patch?

Yep.  We already have a fix; I just need to put it in my queue.

> Are the other patches independent of this?  Should I apply all the
> others, or do I need to wait for the fixed version of this one?

They're all independent of this, so please fire away.

Thanks,

	<b


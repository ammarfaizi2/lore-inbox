Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUBLCAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 21:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUBLCAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 21:00:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:6363 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261575AbUBLCAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 21:00:40 -0500
Date: Wed, 11 Feb 2004 18:00:19 -0800
From: Dave Olien <dmo@osdl.org>
To: Diego Calleja <grundig@teleline.es>
Cc: Michael Frank <mhf@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved writes
Message-ID: <20040212020019.GA22344@osdl.org>
References: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com> <200402120502.39300.mhf@linuxmail.org> <20040211221806.106eed62.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040211221806.106eed62.grundig@teleline.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4 does not have deadline scheduler.  But the 2.6 deadline scheduler
is more similar to 2.4's scheduler than is the anticipatory scheduler.

Re-try 2.6 with deadline scheduler will remove some of the additional
scheduler policies that are present in the anticipatory scheduler.

On Wed, Feb 11, 2004 at 10:18:06PM +0100, Diego Calleja wrote:
> El Thu, 12 Feb 2004 05:02:39 +0800 Michael Frank <mhf@linuxmail.org> escribió:
> 
> 
> > 2.4 has a deadline scheduler. 2.6 default is anticipatory.
> 
> I though the 2.4 io scheduler wasn't "deadline" base, I think the first
> "deadline" io scheduler was the one merged ~2.5.39
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

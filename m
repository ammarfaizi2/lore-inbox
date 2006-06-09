Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWFIXTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWFIXTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWFIXTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:19:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932592AbWFIXTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:19:43 -0400
Date: Fri, 9 Jun 2006 16:22:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: nagar@watson.ibm.com, balbir@in.ibm.com, jlan@sgi.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060609162232.2f2479c5.akpm@osdl.org>
In-Reply-To: <4489F93E.6070509@engr.sgi.com>
References: <44892610.6040001@watson.ibm.com>
	<20060609010057.e454a14f.akpm@osdl.org>
	<448952C2.1060708@in.ibm.com>
	<20060609042129.ae97018c.akpm@osdl.org>
	<4489EE7C.3080007@watson.ibm.com>
	<4489F93E.6070509@engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@engr.sgi.com> wrote:
>
> If you can show me how to not sending per-tgid with current patchset,
> i would be very happy to drop this request.

pleeeze, not a global sysctl.  It should be some per-client subscription thing.

But the overhead at present is awfully low.  If we don't need this ability
at present (and I don't think we do) then a paper design would be
sufficient at this time.  As long as we know we can do this in the future
without breaking existing APIs then OK.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWEARD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWEARD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWEARD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:03:27 -0400
Received: from test-iport-1.cisco.com ([171.71.176.117]:5674 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932154AbWEARD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:03:26 -0400
To: Heiko Joerg Schick <info@schihei.de>
Cc: openib-general@openib.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device Driver
X-Message-Flag: Warning: May contain useful information
References: <4450B378.9000705@de.ibm.com>
	<20060427125726.GK32127@wohnheim.fh-wedel.de>
	<e2r7a0$fo2$1@sea.gmane.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 10:03:24 -0700
In-Reply-To: <e2r7a0$fo2$1@sea.gmane.org> (Heiko Joerg Schick's message of "Thu, 27 Apr 2006 21:50:28 +0200")
Message-ID: <ada8xply8wz.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 17:03:25.0432 (UTC) FILETIME=[28F89780:01C66D41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Heiko> I don't like the idea to put the whole driver in one patch
    Heiko> file. I would propose to put the patch "ehca: integration
    Heiko> in Linux kernel" last instead of first, as Arnd
    Heiko> mentioned. With that change we leave the kernel in a
    Heiko> working state when applying the patches.

Yes, that makes sense.

And I can fold the patches into a single git changeset when we finally
merge it, since I don't see any advantage to having the driver split
into pieces.  (No one is going to git biset a half-applied driver or
anything like that)

 - R.

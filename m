Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264932AbUE0STq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbUE0STq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUE0STq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:19:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264932AbUE0STn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:19:43 -0400
Message-ID: <40B63132.4050906@pobox.com>
Date: Thu, 27 May 2004 14:19:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org
Subject: Re: [PATCH 0/14] prism54: bring up to sync with prism54.org cvs rep
References: <20040524083003.GA3330@ruslug.rutgers.edu>
In-Reply-To: <20040524083003.GA3330@ruslug.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis R. Rodriguez wrote:
> [PATCH 1/14 linux-2.6.7-rc1] prism54: add new private ioctls
> [PATCH 2/14 linux-2.6.7-rc1] prism54: reset card on tx_timeout
> [PATCH 3/14 linux-2.6.7-rc1] prism54: add iwspy support
> [PATCH 4/14 linux-2.6.7-rc1] prism54: add support for avs header in monitor mode
> [PATCH 5/14 linux-2.6.7-rc1] prism54: new prism54 kernel compatibility
> [PATCH 6/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 74, 75
> [PATCH 7/14 linux-2.6.7-rc1] prism54: Fix 2.4 build
> [PATCH 8/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 39, 73
> [PATCH 9/14 linux-2.6.7-rc1] prism54: Fix prism54.org bug 77; strengthened oid transaction
> [PATCH 10/14 linux-2.6.7-rc1] prism54: Don't allow mib reads while unconfigured
> [PATCH 11/14 linux-2.6.7-rc1] prism54: Touched up kernel compatibility
> [PATCH 12/14 linux-2.6.7-rc1] prism54: Start using likely/unlikely
> [PATCH 13/14 linux-2.6.7-rc1] prism54: Fix 2.4 SMP build
> [PATCH 14/14 linux-2.6.7-rc1] prism54: Fix channel stats; bump to 1.2


I'm reviewing these now.

I am worried though -- the first couple patches include a TON of 
whitespace changes and cleanups unrelated to the patch at hand.  This 
makes it MUCH more difficult to review each patch.

I'm considering rejecting the entire series because of this obfuscation 
of changes, and getting you to resend with the whitespace crapola 
separated out.

	Jeff



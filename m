Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUGOB34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUGOB34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 21:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUGOB3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 21:29:55 -0400
Received: from holomorphy.com ([207.189.100.168]:17313 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263019AbUGOB3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 21:29:41 -0400
Date: Wed, 14 Jul 2004 18:29:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Zaitsev <peter@mysql.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040715012932.GE3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Zaitsev <peter@mysql.com>, Andrea Arcangeli <andrea@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040715000438.GS974@dualathlon.random> <20040715004350.GD3411@holomorphy.com> <1089853483.15336.4035.camel@abyss.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089853483.15336.4035.camel@abyss.home>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 17:43, William Lee Irwin III wrote:
>> I wouldn't be so quick to dismiss it. There are enough physical
>> placement issues already even without pinned userspace pages.

On Wed, Jul 14, 2004 at 06:04:45PM -0700, Peter Zaitsev wrote:
> You and Andrey are mentioning "pinned" pages. Does this corresponds to 
> locked (ie memlock()) pages ? 
> In my case I did not have any locked pages at all. 

All anonymous userspace pages are now pinned when there is no swap.


-- wli

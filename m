Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267965AbUHEUsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267965AbUHEUsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267964AbUHEUrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:47:16 -0400
Received: from holomorphy.com ([207.189.100.168]:3270 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267967AbUHEUqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:46:18 -0400
Date: Thu, 5 Aug 2004 13:46:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Mr. Berkley Shands" <berkley@cse.wustl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Message-ID: <20040805204615.GJ17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Mr. Berkley Shands" <berkley@cse.wustl.edu>,
	linux-kernel@vger.kernel.org
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com> <4112917A.3080003@cse.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4112917A.3080003@cse.wustl.edu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> By any chance could you do binary search on the bk snapshots between
>> 2.6.6 and 2.6.7?

On Thu, Aug 05, 2004 at 02:58:50PM -0500, Mr. Berkley Shands wrote:
> the problem does not exist using 2.6.6-bk6, but exists on 2.6.6-bk7. 
> -bk8 and -bk9 faile to build.
> these are from patches-2.6.6-bk6 off snapshots/old and applied to a 
> vanilla 2.6.6 kernel.

This is the closest it appears to be possible to narrow down where the
regression happened.

Some form of changelogging to enumerate what the contents of the
2.6.6-bk6 -> 2.6.6-bk7 delta are and to reconstruct intermediate points
between 2.6.6-bk6 and 2.6.6-bk7 is needed.

I have already tried to carry out various procedures to accomplish this
for several other problem reports and/or issues and come have come away
from the effort highly discouraged (having made zero progress) each time.


-- wli

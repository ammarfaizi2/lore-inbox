Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276097AbRJBSQa>; Tue, 2 Oct 2001 14:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276095AbRJBSQU>; Tue, 2 Oct 2001 14:16:20 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:35724
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S276098AbRJBSQE>; Tue, 2 Oct 2001 14:16:04 -0400
Date: Tue, 02 Oct 2001 14:16:28 -0400
From: Chris Mason <mason@suse.com>
To: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Which is currently the most stable 2.4 kernel?
Message-ID: <306940000.1002046587@tiny>
In-Reply-To: <20011002180502.25799.qmail@web13102.mail.yahoo.com>
In-Reply-To: <20011002180502.25799.qmail@web13102.mail.yahoo.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, October 02, 2001 11:05:02 AM -0700 Chris Rankin
<rankincj@yahoo.com> wrote:

> All that the servers would be doing would be
> connecting to the Internet periodically using PPPoE
> and DSL (with NAT), forwarding emails and performing
> various CPU-bound tasks. They should both have ample
> available memory and should not need to swap much, if
> at all.
> 
> Does anyone have any kernel recommendations /
> counter-recommendations, please? One server is SMP,
> the other is UP, and both are Intel architecture.

PPP is not SMP safe in 2.4.x.  You'll run into problems on any kernel
there.  Even on single processor systems, you need the ppp patch in
2.4.9-ac16 or 2.4.11pre1.

Other than that, 2.4.10 + andrea's vmtweaks patch does well.  2.4.9-ac18 is
a good alternative.

-chris


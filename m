Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTEaJyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 05:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTEaJyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 05:54:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:18593 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S264265AbTEaJyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 05:54:09 -0400
Date: Sat, 31 May 2003 11:09:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Russell King <rmk@arm.linux.org.uk>
cc: Jun Sun <jsun@mvista.com>, <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Properly implement flush_dcache_page in 2.4?  (Or is it
    possible?)
In-Reply-To: <20030531101932.B19071@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305311105180.1654-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Russell King wrote:
> On Sat, May 31, 2003 at 09:33:04AM +0100, Hugh Dickins wrote:
> > that's a possibility), the "unspecified" would allow that much - but
> > wouldn't allow you to show portions of entirely other files!
> 
> Other files should not be stored in the same page though - if that's
> happening today, then we have a violation of POSIX, wrong from Linus'
> "quality of implementation" standpoint, and its a security hole.

Sorry, false alarm, I didn't mean to imply that was happening anywhere:
I was just giving a throwaway example of how, though a standard might
say "unspecified", there are still limits to what's allowed - yes,
"quality of implementation" is a good measure.

Hugh


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTL1Qk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 11:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTL1Qk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 11:40:28 -0500
Received: from holomorphy.com ([199.26.172.102]:31922 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261731AbTL1Qk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 11:40:27 -0500
Date: Sun, 28 Dec 2003 08:39:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031228163952.GQ22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Anton Ertl <anton@mips.complang.tuwien.ac.at>,
	linux-kernel@vger.kernel.org
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it> <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org> <m1smj596t1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0312272046400.2274@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312272046400.2274@home.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003, Eric W. Biederman wrote:
>> For anyone taking you up on this I'd like to suggest two possible
>> directions.
>> 1) Increasing PAGE_SIZE in the kernel.

On Sat, Dec 27, 2003 at 08:53:30PM -0800, Linus Torvalds wrote:
> Yes. This is something I actually want to do anyway for 2.7.x. Dan 
> Phillips had some patches for this six months ago.
> You have to be careful, since you have to be able to mmap "partial pages", 
> which is what makes it less than trivial, but there are tons of reasons to 
> want to do this, and cache coloring is actually very much a secondary 
> concern.

I've not seen Dan Phillips' code for this. I've been hacking on
something doing this since late last December.


-- wli

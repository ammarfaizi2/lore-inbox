Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTL2Cz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 21:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTL2Cz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 21:55:29 -0500
Received: from holomorphy.com ([199.26.172.102]:65203 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262458AbTL2Cz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 21:55:28 -0500
Date: Sun, 28 Dec 2003 18:55:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: mfedyk@matchmail.com, Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031229025507.GT22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mfedyk@matchmail.com, Linus Torvalds <torvalds@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Anton Ertl <anton@mips.complang.tuwien.ac.at>,
	linux-kernel@vger.kernel.org
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it> <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org> <m1smj596t1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0312272046400.2274@home.osdl.org> <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229003631.GE1882@matchmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 08:53:30PM -0800, Linus Torvalds wrote:
>>> Yes. This is something I actually want to do anyway for 2.7.x. Dan 
>>> Phillips had some patches for this six months ago.
>>> You have to be careful, since you have to be able to mmap "partial pages", 
>>> which is what makes it less than trivial, but there are tons of reasons to 
>>> want to do this, and cache coloring is actually very much a secondary 
>>> concern.

On Sun, Dec 28, 2003 at 08:39:52AM -0800, William Lee Irwin III wrote:
>> I've not seen Dan Phillips' code for this. I've been hacking on
>> something doing this since late last December.

On Sun, Dec 28, 2003 at 04:36:31PM -0800, Mike Fedyk wrote:
> I remember his work on pagetable sharing, but haven't heard anything about
> changing the page size from him.
> Could this be what Linus is remembering?

Doubtful. I suspect he may be referring to pgcl (sometimes called
"subpages"), though Dan Phillips hasn't been involved in it. I guess
we'll have to wait for Linus to respond to know for sure.


-- wli

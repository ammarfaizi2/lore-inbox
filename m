Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTEMWnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbTEMWmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:42:22 -0400
Received: from holomorphy.com ([66.224.33.161]:53693 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263503AbTEMWkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:40:32 -0400
Date: Tue, 13 May 2003 15:52:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       Christoph Hellwig <hch@infradead.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513225256.GY8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Christoph Hellwig <hch@infradead.org>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk> <20030513163854.A27407@infradead.org> <20030513131754.7f96d4d0.akpm@digeo.com> <20030513222532.GA13317@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513222532.GA13317@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:17:54PM -0700, Andrew Morton wrote:
>> But I do not view non-ia32 support as being a 2.6.0 requirement.  I'd be OK
>> with 2.6.0 working _only_ on ia32.  Other architectures will catch up when
>> they can.  The only core requirement is that 2.6.0 not contain gross
>> x86isms which make other ports impossible.

On Tue, May 13, 2003 at 11:25:32PM +0100, Dave Jones wrote:
> I kinda sorta agree. Holding up 2.6.0 for other ports to catch up
> could end up with us waiting, and in the meantime, Linus merging other
> stuff which could break non-x86 etc..
> Once we're into 2.6.x though, would it be unfeasable to hold off on
> final point releases until arch maintainers have sent in a 'make things
> work for this release' diff ? Ie, make rc's "strict bugfixes only, and
> arch updates"
> Though, for some archs (sparc32 springs to mind), we may end up waiting
> quite a while, so perhaps just settle on a handful of 'to be kept
> up-to-date' archs ?

MIPS seems to be taking a while too.


-- wli

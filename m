Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUDBXoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 18:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUDBXoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 18:44:18 -0500
Received: from holomorphy.com ([207.189.100.168]:28341 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261405AbUDBXoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 18:44:17 -0500
Date: Fri, 2 Apr 2004 15:44:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402234400.GT791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@suse.cz>, Andrea Arcangeli <andrea@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	kenneth.w.chen@intel.com
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040402103923.GB677@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402103923.GB677@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Something like this would have the minor advantage of zero core impact.
>> Testbooted only. vs. 2.6.5-rc3-mm4

On Fri, Apr 02, 2004 at 12:39:23PM +0200, Pavel Machek wrote:
> I thought this is what setpcap in init is for?

Yes, that would be a better answer to this issue. I was largely looking
to produce an alternative implementation of the same thing with less
core impact. It looks like it may have been too powerful for its own
good, which is okay, since I didn't really like the sysctl idea anyway
(though apparently the thing looks attractive to other people for other
uses, which I don't really know much about, and am not really pursuing).

There's a push to fix up the capability issues ongoing that I'm getting
involved in instead.


-- wli
